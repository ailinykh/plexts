require 'dotenv'

module Plexts
    def self.configure
      Dotenv.load
    end

    def self.headers
        cookie = {
            # 'GOOGAPPUID' => ENV["GOOG_APP_UID"], # deprecated
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

    def self.plexts_params(minLatE6, minLngE6, maxLatE6, maxLngE6, maxTimestampMs=-1, tab='all')
        toSend = {
            "minLatE6" => minLatE6.to_s.gsub(/\./, '').to_i,
            "minLngE6" => minLngE6.to_s.gsub(/\./, '').to_i,
            "maxLatE6" => maxLatE6.to_s.gsub(/\./, '').to_i,
            "maxLngE6" => maxLngE6.to_s.gsub(/\./, '').to_i,
            "minTimestampMs" => -1,
            "maxTimestampMs" => maxTimestampMs,
            "tab" => tab,
            "v" => ENV["VERSION"]
        }.to_json
    end

    def self.artifacts_params
        toSend = {
            "v" => ENV["VERSION"]
        }.to_json
    end
    def self.entities_params(lat1, lng1, lat2, lng2, zoom=20)
        toSend = {
            "tileKeys" => get_mercator_tiles(lat1, lng1, lat2, lng2, zoom).shift(25),
            "v" => ENV["VERSION"]
        }.to_json
    end
    def self.entities_params_with_tiles(tiles)
        toSend = {
            "tileKeys" => tiles.shift(25),
            "v" => ENV["VERSION"]
        }.to_json
    end
end
