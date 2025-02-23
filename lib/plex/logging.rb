require 'logger'

module Plex
  module Logging
    def logger
      Logging.logger
    end

    class << self
      def logger
        @logger ||= Logger.new($stdout).tap do |log|
          log.level = Logger::DEBUG
          log.formatter = proc do |severity, datetime, progname, msg|
            "[#{datetime.strftime("%Y-%m-%d %H:%M:%S")}] #{severity}: #{msg}\n"
          end
        end
      end

      def logger=(logger)
        @logger = logger
      end
    end
  end

  def self.included(base)
    base.class_eval do
      include Logging
    end
  end
end
