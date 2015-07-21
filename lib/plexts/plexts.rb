module Plexts

    def self.get_plexts(minLatE6, minLngE6, maxLatE6, maxLngE6, maxTimestampMs=-1, tab='all')
        body = {
            "minLatE6" => minLatE6.to_s.gsub(/\./, '').to_i,
            "minLngE6" => minLngE6.to_s.gsub(/\./, '').to_i,
            "maxLatE6" => maxLatE6.to_s.gsub(/\./, '').to_i,
            "maxLngE6" => maxLngE6.to_s.gsub(/\./, '').to_i,
            "minTimestampMs" => -1,
            "maxTimestampMs" => maxTimestampMs,
            "tab" => tab
        }
        get_intel_data('https://www.ingress.com/r/getPlexts', body)
    end
end
