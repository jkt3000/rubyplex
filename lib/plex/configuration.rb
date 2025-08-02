module Plex
  class Configuration
    attr_accessor :plex_host, :plex_port, :plex_token, :ssl
    attr_reader :logger

    DEFAULT_CONFIG_FILE = File.expand_path('~/.rubyplex.yml')

    def initialize
      @plex_host    = ''
      @plex_port    = 32400
      @plex_token   = nil
      @ssl          = false
      @logger       = Logger.new($stdout)
      @logger.level = Logger::WARN
      set_logger_format
      load_yaml()
    end

    def logger=(output)
      @logger = output.is_a?(Logger) ? output : Logger.new(output)
      set_logger_format
    end

    def log_level=(level)
      @logger.level = Logger.const_get(level.to_s.upcase)
    end

    def load_yaml(path = DEFAULT_CONFIG_FILE)
      return unless File.exist?(path)
      config = YAML.load_file(path).transform_keys(&:downcase).transform_keys(&:to_sym)
      config.each do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    rescue => e
      @logger.warn "Failed to load config file #{path}: #{e.message}"
    end

    def to_h
      {
        plex_host: @plex_host,
        plex_port: @plex_port,
        plex_token: @plex_token,
        ssl: @ssl
      }
    end

    private

    def set_logger_format
      @logger.formatter = proc do |severity, datetime, progname, msg|
        prefix = case severity
        when "WARN"  then "!"
        when "INFO"  then "→"
        when "ERROR" then "✗"
        when "DEBUG" then "•"
        else "•"
        end
        "#{prefix} #{msg}\n"
      end
    end
  end
end
