require 'logger'

module Plex
  module Logging
    class << self

      attr_accessor :logger

      def configure(output: $stdout, level: Logger::INFO, formatter: nil)
        @logger = Logger.new(output)
        @logger.level = level
        @logger.formatter = formatter || default_formatter
      end

      private

      def default_formatter
        proc do |severity, datetime, progname, msg|
          "[#{datetime.strftime("%Y-%m-%d %H:%M:%S")}] #{severity}: #{msg}\n"
        end
      end
    end
  end
end
