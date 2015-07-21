require 'net/http'
require 'net/https'
require 'json'
require 'yaml'

module Plexts

  def self.get_intel_data(url, body={})
    intel = YAML::load(File.open(File.join(Dir.pwd, 'intel.yml')))
    
    cookie = {
      'csrftoken' => intel['csrftoken'],
      'SACSID' => intel['SACSID']
    }
    headers = {
      'content-Type' => 'application/json; charset=UTF-8',
      'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36',
      'x-csrftoken' => intel['csrftoken'],
      'referer' => 'https://www.ingress.com/intel',
      'cookie' => cookie.map{|k,v|
                      "#{k}=#{v}"
                  }.join('; ')
    }

    uri = URI(url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, headers)
    body[:v] = intel["v"]
    req.body = body.to_json
    res = https.request(req)

    case res
      when Net::HTTPSuccess then
        if res.body.include?('Welcome to Ingress')
          json = {error: 'SACSID incorrect'}.to_json
        else
          json = res.body
        end
      when Net::HTTPServerException, Net::HTTPForbidden then
        json = {error: 'csrftoken incorrect'}.to_json
    end
    
    JSON.parse(json)
  end
end