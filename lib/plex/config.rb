module Plex

  class Config
    DEFAULT_CONFIG = {
      plex_host: '127.0.0.1',
      plex_port: 32400,
      plex_token: nil,
      ssl: false
    }.freeze

    class << self
      def load
        @config ||= begin
          config_file = File.expand_path('~/.rubyplex.yml')
          if File.exist?(config_file)
            symbolize_keys(YAML.load_file(config_file).transform_keys(&:downcase))
          else
            DEFAULT_CONFIG.dup
          end
        end
      end

      def set(options = {})
        @config = symbolize_keys(options)
      end

      def [](key)
        load[key.to_sym]
      end

      def reset!
        @config = nil
      end

      def url
        protocol = self[:ssl] ? 'https' : 'http'
        "#{protocol}://#{self[:plex_host]}:#{self[:plex_port]}"
      end

      def plex_token
        self[:plex_token]
      end


      private

      def symbolize_keys(hash)
        hash.transform_keys(&:to_sym)
      end

    end
  end
end
