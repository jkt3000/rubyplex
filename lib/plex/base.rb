module Plex
  class Base

    attr_reader :hash, :server

    TIME_ATTRIBUTES = %w|updatedAt createdAt addedAt scannedAt|
    DATE_ATTRIBUTES = ["originallyAvailableAt"]
    TAG_ATTRIBUTES  = ["Genre", "Director", "Writer", "Country", "Role", "Guid"]

    def initialize(hash)
      @hash = hash
      @server = Plex.server
    end

    def method_missing(method_name, *args)
      key = convert_to_camel(method_name.to_s)

      return tag_values(key) if hash.key?(key.capitalize)
      super unless hash.key?(key)

      value = hash.fetch(key,nil)
      transform_value(key, value)
    end

    def keys
      hash.keys
    end


    private

    def tag_values(key)
      entries = hash.fetch(key.capitalize,[])
      entries.map {|entry| entry}
    end

    def convert_to_camel(arg)
      return arg unless arg.include?('_')
      arg.split('_').then { |parts| parts.first + parts[1..].map(&:capitalize).join }
    end

    def transform_value(key, value)
      case
      when TIME_ATTRIBUTES.include?(key)
        Time.at(value)
      when DATE_ATTRIBUTES.include?(key)
        Date.parse(value)
      else
        value
      end
    end

    def logger
      Plex.logger
    end
  end
end
