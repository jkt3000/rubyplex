require "test_helper"

class MovieTest < Minitest::Test

  def setup
    @server = Plex.server
    stub_request(:get, @server.query_path("/library/sections"))
      .to_return(body: load_response(:libraries))
    stub_request(:get, @server.query_path("/library/sections/1/all?includeGuids=1"))
      .to_return(body: load_response(:library_1))
    @library = @server.library(1)
  end


  # load_details!

  def test_load_details_loads_detail_metadata
    stub_request(:get, @server.query_path("library/metadata/17911")).to_return(body: load_response(:movie1))
    @movie = @library.all.first
    @movie.load_details!
  end

  # new

  def test_new_movie
    @movie = @library.all.first
    assert_equal "2 Guns", @movie.title
    assert @movie.is_a?(Plex::Movie)
    assert_equal 1, @movie.medias.count
  end

  # medias

  def test_medias_returns_array_of_medias_for_movie
    @movie = @library.all.first
    @medias = @movie.medias
    assert @medias.first.is_a?(Plex::Media)
  end

  # files

  def test_files_returns_array_of_media_files
    @movie = @library.all.first
    list = @movie.files
    assert_equal 1, list.size
    assert_equal "/volume1/Media/Movies/2 Guns (2013)/2 Guns (2013) [1080p] [AAC 2ch].mp4", list.first
  end

  # find_by_filename

  def test_find_by_filename_returns_media_that_has_file
    @movie = @library.all.first
    media = @movie.find_by_filename("2 Guns (2013) [1080p] [AAC 2ch].mp4")
    assert media.is_a?(Plex::Media)
  end

  def test_find_by_filename_returns_nil_if_path_doesnt_match_and_full_path_required
    @movie = @library.all.first

    media = @movie.find_by_filename("2 Guns (2013) [1080p] [AAC 2ch].mp4", full_path: true)
    assert_nil media
  end

  def test_find_by_filename_returns_nil_if_file_doesnt_exist
    @movie = @library.all.first

    media = @movie.find_by_filename("Some bad movie [AAC 2ch].mp4")
    assert_nil media
  end

  # release_date

  def test_release_date
    @movie = @library.all.first
    assert_equal @movie.release_date, @movie.originally_available_at
  end

  # genre, director, role, country

  def test_tags
    @movie = @library.all.first
    genres = @movie.genre
    assert_equal 2, genres.size

    assert @movie.director.is_a?(Array)
    assert @movie.role.is_a?(Array)
    assert @movie.country.is_a?(Array)
  end
end
