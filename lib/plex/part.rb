module Plex
  class Part < Plex::Base

    def has_file?(filename, full_path: false)
      full_path ? file == filename : File.basename(file) == File.basename(filename)
    end

    def streams
      hash.fetch("Stream", []).map {|stream| Plex::Stream.new(stream) }
    end
  end
end
