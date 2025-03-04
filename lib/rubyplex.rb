# frozen_string_literal: true

require 'httparty'
require 'json'
require 'yaml'
require 'logger'
require_relative "plex/version"
require_relative "plex/loggable"
require_relative "plex/logger"
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
  DEFAULT_CONFIG = {
    plex_host: '',
    plex_port: 32400,
    plex_token: nil,
    ssl: false
  }.freeze
  DEFAULT_CONFIG_FILE = File.expand_path('~/.rubyplex.yml')

  DEFAULT_LOG_LEVEL = 'WARN'
  extend self

  def plex_settings
    @settings ||= begin
      if File.exist?(DEFAULT_CONFIG_FILE)
        YAML.load_file(DEFAULT_CONFIG_FILE).transform_keys(&:downcase).transform_keys(&:to_sym)
      else
        DEFAULT_CONFIG.dup
      end
    end
  end

  def server
    @server ||= begin
      init_logger
      server = Plex::Server.new(plex_settings)
      server
    end
  end

  def logger
    Plex::Logger.logger
  end

  def init_logger(file = $stdout, log_level: @log_level)
    Plex::Logger.set_logger(file, log_level: log_level())
  end

  def log_level
    @log_level ||= 'WARN'
  end

  def log_level=(level)
    @log_level=(level.to_s.upcase)
    Plex::Logger.set_level(@log_level)
  end
end
