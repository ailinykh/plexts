require 'dotenv'
require 'net/http'
require 'net/https'
require 'json'

module Plexts

  def self.headers
    Dotenv.load
    cookie = {
        'csrftoken' => ENV["CSRF_TOKEN"],
        'SACSID' => ENV['SACS_ID']
    }
    initheaders = {
        'content-Type' => 'application/json; charset=UTF-8',
        'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36',
        'x-csrftoken' => ENV['CSRF_TOKEN'],
        'referer' => 'https://www.ingress.com/intel',
        'cookie' => cookie.map{|k,v|
                        "#{k}=#{v}"
                    }.join('; ')
    }
  end

  def self.get_intel_data(url, body={})
    uri = URI(url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, headers)
    body[:v] = ENV["VERSION"]
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