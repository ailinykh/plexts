require 'net/http'
require 'net/https'
require 'json'

module Plexts

    ZOOM_TO_NUM_TILES_PER_EDGE = [1,1,1,40,40,80,80,320,1000,2000,2000,4000,8000,16000,16000,32000]

    # minLatE6, minLngE6: south west point
    # maxLatE6, maxLngE6: north east point
    def self.get_entities(minLatE6, minLngE6, maxLatE6, maxLngE6, zoom=20)
        if !(minLatE6.between?(-90, 90) && minLngE6.between?(-180, 180)) || !(maxLatE6.between?(-90, 90) && maxLngE6.between?(-180, 180))
            raise StandardError, "irregular parameter"
        end
        configure
        uri = URI('https://www.ingress.com/r/getEntities')
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, headers )
        req.body = entities_params(minLatE6, minLngE6, maxLatE6, maxLngE6, zoom)
        res = https.request(req)
        if !res.kind_of? Net::HTTPSuccess
            raise res.code + ":" + res.msg
        end
        # puts "Response #{res.code} #{res.message}: #{res.body}"
        json = JSON.parse(res.body)
        # JSON.pretty_generate(json)
    end

    # parameter sample
    # 17_7994_3544_0_8_100
    # 17: zoom level
    # 7994: mercator tile lan param
    # 3544: mercator tile lng param
    # 0: min portal level(0-8)
    # 8: max portal level(0-8)
    # 100: max portal health (25, 50, 75, 100)
    def self.get_mercator_tiles(minLatE6, minLngE6, maxLatE6, maxLngE6, zoom=17, pMinLevel=0, pMaxLevel=8, maxHealth=100)
        z = ZOOM_TO_NUM_TILES_PER_EDGE[zoom] || 32000
        lat1_tile = self.get_tile_for_lat(minLatE6, z)
        lat2_tile = self.get_tile_for_lat(maxLatE6, z)
        lng1_tile = self.get_tile_for_lng(minLngE6, z)
        lng2_tile = self.get_tile_for_lng(maxLngE6, z)
        tiles = []
        for x in lng1_tile..lng2_tile
            for y in lat2_tile..lat1_tile
                tiles.push([zoom, x, y, pMinLevel, pMaxLevel, maxHealth].join('_'))
            end
        end
        tiles
    end

    def self.get_tile_for_lat(lat, z)
        ((1 - Math.log(Math.tan(lat * Math::PI / 180) + 1 / Math.cos(lat * Math::PI / 180)) / Math::PI) / 2 * z).to_i
    end

    def self.get_tile_for_lng(lng, z)
        ((lng + 180) / 360 * z).to_i
    end
end
