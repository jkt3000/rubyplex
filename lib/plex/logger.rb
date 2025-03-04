module Plex
  module Logger
    extend self

    def logger
      @logger ||= set_logger
    end

    def set_logger(file = $stdout, log_level: Plex.log_level)
      puts "Initializing logger to #{file} #{log_level}"
      @logger = ::Logger.new(file)
      @logger.level = ::Logger.const_get(log_level.to_s.upcase)
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
      @logger
    end

    def set_level(level)
      return unless logger
      @logger.level = ::Logger.const_get(level.to_s.upcase)
    end
  end
end
