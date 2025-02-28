# /library/sections
# "Directory" => [
# { "allowSync"=>true,
#   "art"=>"/:/resources/movie-fanart.jpg",
#   "composite"=>"/library/sections/8/composite/1542179087",
#   "filters"=>true,
#   "refreshing"=>false,
#   "thumb"=>"/:/resources/movie.png",
#   "key"=>"8",
#   "type"=>"movie",
#   "title"=>"4K Movies",
#   "agent"=>"com.plexapp.agents.imdb",
#   "scanner"=>"Plex Movie Scanner",
#   "language"=>"en",
#   "uuid"=>"36b7bf82-784e-4c0c-a219-e51549ebc255",
#   "updatedAt"=>1536625963,
#   "createdAt"=>1512309737,
#   "scannedAt"=>1542179087,
#   "Location"=>
#    [{"id"=>17, "path"=>"/volume4/Media2/Movies_HQ"},
#     {"id"=>22, "path"=>"/volume4/Media2/hq_downloads"}]}
# ]

module Plex
  class Library < Plex::Base

    def id
      key.to_i
    end

    def paths
      hash.fetch('Location', []).map {|l| l.fetch('path')}
    end

    def total_count
      @total_count ||= begin
        response = server.query(query_path("all"), options: {page: 1, per_page: 0})
        response.fetch('totalSize').to_i
      end
    end

    def all(options: {})
      @all ||= get_entries('all', options: options)
    end

    def entries(options: {})
      get_entries('all', options: options)
    end

    def newest(options: {})
      get_entries('newest', options: options)
    end

    def recently_added(options: {})
      get_entries('recentlyAdded', options: options)
    end

    def find_by_filename(filename, full_path: false)
      all.detect {|entry| entry.find_by_filename(filename, full_path: full_path)}
    end

    def find_by_title(title)
      all.detect {|video| video.title == title }
    end

    def find_by_year(year)
      all.select {|video| video.year.to_i == year.to_i}
    end

    def movie_library?
      type == 'movie'
    end

    def show_library?
      type == 'show'
    end

    def inspect
      "#<Plex::Library title=#{title} paths=#{paths}>"
    end
    private

    def query_path(path)
      "/library/sections/#{id}/#{path}"
    end

    def get_entries(path, options: {})
      options.merge!({includeGuids: 1})
      entries = server.query(query_path(path), options: options)
      entries.map do |entry|
        movie_library? ? Plex::Movie.new(entry) : Plex::Show.new(entry)
      end
    end
  end
end
