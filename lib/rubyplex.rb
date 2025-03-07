# frozen_string_literal: true

require 'httparty'
require 'json'
require 'yaml'
require 'logger'
require_relative "plex/version"
require_relative "plex/configuration"
require_relative "plex/auth"
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
  extend self

  def configure
    @config ||= Configuration.new
    yield(@config) if block_given?
    @config
  end

  def server
    @server ||= begin
      config = configure
      Plex::Server.new(config.to_h)
    end
  end

  def logger
    configure.logger
  end

  def log_level=(level)
    level = level.to_s.upcase
    logger.level = Logger.const_get(level)
  end

  def update_server(settings)
    required_keys = [:plex_host, :plex_port, :plex_token, :ssl]
    missing_keys = required_keys.select { |key| !settings.key?(key) }
    unless missing_keys.empty?
      raise StandardError, "Missing required params: #{missing_keys.join(', ')}"
    end
    Plex.server.settings = settings
    Plex.server
  end

  def reset!
    @config = nil
    @server = nil
  end
end
