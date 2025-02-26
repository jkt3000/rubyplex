# frozen_string_literal: true

require 'httparty'
require 'json'
require 'yaml'
require 'logger'
require_relative "plex/version"
require_relative "plex/logging"
require_relative "plex/loggable"
require_relative "plex/server"
require_relative "plex/base"
require_relative "plex/library"
require_relative "plex/movie"
require_relative "plex/show"
require_relative "plex/episode"
require_relative "plex/media"
require_relative "plex/part"
require_relative "plex/stream"

module Plex
  class Error < StandardError; end

  extend self

  DEFAULT_CONFIG = {
    plex_host: '',
    plex_port: 32400,
    plex_token: nil,
    ssl: false
  }

  # Store configuration at module level
  @settings = begin
    config_file = File.expand_path('~/.rubyplex.yml')
    if File.exist?(config_file)
      YAML.load_file(config_file).transform_keys(&:downcase).transform_keys(&:to_sym)
    else
      DEFAULT_CONFIG.dup
    end
  end

  def configure
    yield(Configuration.new)
  end

  def settings
    @settings
  end

  def server
    @server ||= begin
      Plex::Logging.logger = Logger.new($stdout)
      Plex::Logging.logger.level = ::Logger::INFO
      Plex::Server.new(@settings)
    end
  end

  class Configuration
    VALID_OPTIONS = [:plex_host, :plex_port, :plex_token, :ssl]

    def settings=(options)
      unless options.is_a?(Hash)
        raise ArgumentError, "Settings must be a Hash"
      end

      invalid_options = options.keys - VALID_OPTIONS
      unless invalid_options.empty?
        raise ArgumentError, "Invalid options: #{invalid_options.join(', ')}"
      end

      Plex.settings.merge!(options)
    end

    def logger=(logger)
      Plex::Logging.logger = logger
    end

    def setup_logging(output: $stdout, level: Logger::INFO, formatter: nil)
      Plex::Logging.configure(output: output, level: level, formatter: formatter)
    end
  end
end

# # Simple configuration
# Plex.configure do |config|
#   config.settings = { plex_host: '..', plex_port: 32400, plex_token: '...' }
#   config.setup_logging(level: Logger::DEBUG)
# end

# # Custom logger
# Plex.configure do |config|
#   config.logger = Logger.new('custom.log')
# end
