module Plex
  class Server
    include Plex::Loggable

    QUERY_PARAMS = %w| type year decade sort includeGuids |

    attr_reader :url, :token, :settings

    def initialize(options = {})
      @settings = Plex::DEFAULT_CONFIG.merge(options)
      @url      = server_url
      @token    = settings[:plex_token]
      @headers  = {
        "X-Plex-Token" => token,
        "Accept"       => "application/json"
      }
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

    def query(path, options: {})
      pagination_headers = pagination_params(options)
      query_params = parse_query_params(options)
      logger.debug("Query Params: #{query_params}")
      request_options = {
        headers: @headers.merge(pagination_headers),
      }
      request_options[:query] = query_params unless query_params.empty?
      get(query_path(path), options: request_options)
    end

    def query_path(path)
      File.join(@url,path)
    end

    def inspect
      "#<Plex::Server #{settings}>"
    end


    private

    def server_url
      protocol = settings[:ssl] ? 'https' : 'http'
      "#{protocol}://#{settings[:plex_host]}:#{settings[:plex_port]}"
    end

    def get(url, options: {})
      logger.debug("GET #{url} #{options}")
      response = HTTParty.get(url, options)
      body = JSON.parse(response.body)
      logger.debug("Response Code: #{response.code}")
      logger.debug("Response Body: #{body}")
      data = body.fetch("MediaContainer", {})
      data.key?("Metadata") ? data.fetch("Metadata", []) : data
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
      params  = options.slice(*QUERY_PARAMS)
      params
    end
  end
end
