module Plex
  class Server

    QUERY_PARAMS = %w[
      type year decade sort includeGuids
      updatedAt addedAt title summary
      rating contentRating studio network
      genre director writer actor producer
      resolution audioCodec videoCodec
      limit offset container
    ].freeze

    attr_reader :settings
    attr_accessor :url, :token

    def initialize(options = {})
      @settings = options
      set_params
    end

    def libraries
      response = query("/library/sections")
      response.fetch("Directory", []).map {|l| Plex::Library.new(l) }
    end

    # find by id or title
    def library(id_or_title)
      libraries.detect {|library| id_or_title.is_a?(String) ? library.title == id_or_title : library.id == id_or_title.to_i }
    end

    def library_by_path(path)
      path = File.dirname(File.join(path, 'foo.bar'))
      if found = libraries.detect {|l| l.paths.include?(path) }
        return found
      end

      # detect subpaths
      path_chunks = path.split("/").reject(&:empty?)
      (path_chunks.length-1).downto(1).each do |i|
        subpath = path_chunks[i]
        if found = libraries.detect {|l| l.paths.any? {|d| d.end_with?(subpath) } }
          return found
        end
      end
      nil
    end

    def query(path, **options)
      pagination_headers = pagination_params(options)
      query_params = parse_query_params(options)
      logger.debug("Query Params: #{query_params}")

      request_options = {
        headers: @headers.merge(pagination_headers)
      }

      # Build URL manually to avoid encoding issues with operators
      full_url = build_query_url(path, query_params)

      get(full_url, options: request_options)
    end

    def query_path(path)
      File.join(@url,path)
    end

    def inspect
      "#<Plex::Server #{settings}>"
    end

    def settings=(settings = {})
      @settings = settings
      set_params
    end


    private

    def set_params
      @url   = server_url
      @token = settings[:plex_token]
      @headers  = {
        "X-Plex-Token" => token,
        "Accept"       => "application/json"
      }
    end

    def server_url
      protocol = settings[:ssl] ? 'https' : 'http'
      "#{protocol}://#{settings[:plex_host]}:#{settings[:plex_port]}"
    end

    def get(url, options: {})
      logger.debug("GET #{url} #{options}")

      begin
        response = HTTParty.get(url, options)
        logger.debug("Response Code: #{response.code}")

        unless response.success?
          logger.error("HTTP Error: #{response.code} - #{response.message}")
          raise Plex::Error, "HTTP Error: #{response.code} - #{response.message}"
        end

        body = JSON.parse(response.body)
        logger.debug("Response Body: #{body}")

        data = body.fetch("MediaContainer", {})
        data.key?("Metadata") ? data.fetch("Metadata", []) : data
      rescue JSON::ParserError => e
        logger.error("JSON Parse Error: #{e.message}")
        raise Plex::Error, "Invalid JSON response: #{e.message}"
      rescue => e
        logger.error("Request Error: #{e.message}")
        raise Plex::Error, "Request failed: #{e.message}"
      end
    end

    def pagination_params(options)
      offset   = options.fetch(:page, 1).to_i - 1
      per_page = options.fetch(:per_page, nil)
      return {} if per_page.nil?

      {
        "X-Plex-Container-Start" => (offset * per_page).to_s,
        "X-Plex-Container-Size"  => per_page.to_s
      }
    end

    def parse_query_params(options)
      options = options.transform_keys(&:to_s)
      params = {}

      # Handle all parameters - check if they're valid
      options.each do |key, value|
        logger.debug("Processing param: '#{key}' = '#{value}'")
        # Handle standard parameters directly
        if QUERY_PARAMS.include?(key)
          params[key] = value
        # Handle parameters with operators (e.g., updatedAt>=2025-08-01)
        elsif key.match(/^(.+?)([><=!]+)$/)
          base_param = $1
          operator = $2
          logger.debug("Found operator param: base='#{base_param}', operator='#{operator}'")
          # Only include if the base parameter is in our allowed list
          if QUERY_PARAMS.include?(base_param)
            # Construct the proper parameter name with operator
            param_name = "#{base_param}#{operator}"
            params[param_name] = value
            logger.debug("Added operator param: '#{param_name}' = '#{value}'")
          end
        end
      end

      params
    end

    def build_query_url(path, query_params)
      base_url = query_path(path)
      return base_url if query_params.empty?

      # Build query string manually to preserve operators
      query_string = query_params.map do |key, value|
        if key.match?(/[><=!]+$/)
          # For operator keys like "updatedAt>=", don't add another equals
          "#{key}#{CGI.escape(value.to_s)}"
        else
          "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
        end
      end.join('&')

      "#{base_url}?#{query_string}"
    end

    def logger
      Plex.logger
    end
  end
end
