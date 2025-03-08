module Plex
  module Auth
    extend self

    NEW_PIN_URL       = "https://plex.tv/api/v2/pins"
    VALIDATE_PIN_URL  = "https://plex.tv/api/v2/pins/%{pin_id}"
    SERVERS_URL       = "https://plex.tv/api/v2/resources"
    CLIENT_IDENTIFIER = "com.rubyplex.app"

    HEADERS = {
      "Accept"                   => "application/json",
      "X-Plex-Client-Identifier" => CLIENT_IDENTIFIER,
      "X-Plex-Product"           => "RubyPlex",
      "X-Plex-Version"           => Plex::VERSION
    }

    # sample response:
    # {
    # 	"id": 1174342418,
    # 	"code": "KYLX",
    # 	"product": "RubyPlex",
    # 	"trusted": false,
    # 	"qr": "https://plex.tv/api/v2/pins/qr/KYLX",
    # 	"clientIdentifier": "com.rubyplex.app",
    # 	"location": {
    # 		"code": "CA",
    # 		"european_union_member": false,
    # 		"continent_code": "NA",
    # 		"country": "Canada",
    # 		"city": "Toronto",
    # 		"time_zone": "America/Toronto",
    # 		"postal_code": "M5J",
    # 		"in_privacy_restricted_country": false,
    # 		"in_privacy_restricted_region": false,
    # 		"subdivisions": "Ontario",
    # 		"coordinates": "43.6227, -79.3892"
    # 	},
    # 	"expiresIn": 900,
    # 	"createdAt": "2025-03-07T16:37:05Z",
    # 	"expiresAt": "2025-03-07T16:52:05Z",
    # 	"authToken": null,
    # 	"newRegistration": null
    # }

    # request a pin for authenticating plex login
    def request_pin(strong: false)
      response = HTTParty.post(NEW_PIN_URL, headers: HEADERS, query: { strong: strong })
      log.debug("PIN Response Code: #{response.code} Body: #{response.body}")

      if response.success?
        JSON.parse(response.body)
      else
        log.error("Failed to request PIN: #{response.code}")
        nil
      end
    end

    # check until auth received, or expiresAt is exceeded
    def validate_pin(hash = {})
      url        = VALIDATE_PIN_URL % { pin_id: hash.fetch('id', '')}
      response   = HTTParty.get(url, headers: HEADERS)
      log.debug("Validate pin: #{response.body}")

      if response.success?
        JSON.parse(response.body)
      else
        log.error("Failed to get validate pin #{url} request #{response.code}")
        nil
      end
    end


    # return an array of connections of Plex servers
    # each connection has address, port, accessToken, httpRequired
    def get_servers(token: nil)
      headers = HEADERS.dup.merge({'X-Plex-Token' => token})
      response = HTTParty.get(SERVERS_URL, headers: headers, query: {"includesHttps" => 1})
      if !response.success?
        log.error("Error requesting https://plex.tv/api/v2/resources?includeHttps=1")
        nil
      end

      data = JSON.parse(response.body)
      servers = data.select {|entry| entry.dig('provides')&.include?('server')}
      log.debug("Found #{servers.count} that act as Plex Servers")
      connections = servers.map do |server|
        hash = server.slice("name", "product", "clientIdentifier", "publicAddress", "accessToken", "httpsRequired")
        connections = server.dig('connections')
        connections.map {|connection| hash.dup.merge(connection)}
      end.flatten.compact
    end

    def get_server_settings(token: nil)
      connections = get_servers(token: token)
      connections.map do |connection|
        {
          plex_host: connection.fetch('address'),
          plex_port: connection.fetch('port'),
          plex_token: connection.fetch('accessToken'),
          ssl: connection.fetch('httpsRequired')
        }
      end
    end


    private

    def log
      Plex.logger
    end
  end
end
