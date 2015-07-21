module Plexts

    def self.get_portal_details(guid)
    	body = {
    		"guid" => guid
    	}
        get_intel_data('https://www.ingress.com/r/getPortalDetails', body)
    end
end