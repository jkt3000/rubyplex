# frozen_string_literal: true

require 'httparty'
require 'json'
require 'yaml'
require_relative "plex/version"
require_relative 'plex/config'
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

  def configure
    yield(Configuration.new)
  end

  def server
    Plex::Server.new
  end

  class Configuration
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
#   config.setup_logging(level: Logger::DEBUG)
# end

# # Custom logger
# Plex.configure do |config|
#   config.logger = Logger.new('custom.log')
# end
