module Plexts

    def self.get_plexts(minLatE6, minLngE6, maxLatE6, maxLngE6, maxTimestampMs=-1, tab='all')
        body = {
            "minLatE6" => ("%.06f" % minLatE6).gsub(/\./, '').to_i,
            "minLngE6" => ("%.06f" % minLngE6).gsub(/\./, '').to_i,
            "maxLatE6" => ("%.06f" % maxLatE6).gsub(/\./, '').to_i,
            "maxLngE6" => ("%.06f" % maxLngE6).gsub(/\./, '').to_i,
            "minTimestampMs" => -1,
            "maxTimestampMs" => maxTimestampMs,
            "tab" => tab
        }
        get_intel_data('https://www.ingress.com/r/getPlexts', body)
    end
end
