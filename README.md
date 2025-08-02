# RubyPlex

RubyPlex is a Ruby gem for interacting with the Plex Media Server HTTP API. It provides a simple, idiomatic Ruby interface for authenticating with Plex, browsing your media libraries, and managing your server programmatically.

## Features

- Easy configuration via Ruby or YAML
- PIN-based authentication flow (Plex.tv link)
- Access to Plex libraries, movies, TV shows, and episodes
- Native Ruby object mapping for Plex resources
- Flexible logging with configurable output and levels
- SSL support

## Technical Stack & Dependencies

- Ruby (>= 2.5)
- [HTTParty](https://github.com/jnunemaker/httparty) for HTTP requests
- [Minitest](https://github.com/minitest/minitest) for testing
- [WebMock](https://github.com/bblimke/webmock) and [Mocha](https://github.com/freerange/mocha) for test stubbing/mocking
- Standard Ruby libraries: `logger`, `yaml`, `json`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubyplex'
```

Or install it directly:

```bash
gem install rubyplex
```

## Configuration

You can configure RubyPlex using either a YAML file or Ruby code. Configuration is flexible and supports different environments including standalone Ruby projects and Rails applications.

### Default Configuration (Standalone Ruby Applications)

By default, RubyPlex loads configuration from `~/.rubyplex.yml`:

```yaml
plex_host: 'localhost'
plex_port: 32400
plex_token: 'your-plex-token'
ssl: false
```

### Ruby Configuration Block

```ruby
Plex.configure do |config|
  config.plex_host = 'localhost'
  config.plex_port = 32400
  config.plex_token = 'your-plex-token'
  config.ssl = false
  config.log_level = :info
end
```

### Rails Application Setup

#### 1. Add to Gemfile
```ruby
gem 'rubyplex'
```

#### 2. Create an initializer
Create `config/initializers/rubyplex.rb`:

```ruby
Plex.configure do |config|
  config.plex_host = ENV['PLEX_HOST'] || 'localhost'
  config.plex_port = ENV['PLEX_PORT'] || 32400
  config.plex_token = ENV['PLEX_TOKEN']
  config.ssl = ENV['PLEX_SSL'] == 'true'
  config.log_level = Rails.env.production? ? :warn : :info
  config.logger = Rails.logger if Rails.env.development?
end
```

#### 3. Environment Variables
Add to your `.env` file or environment:

```bash
PLEX_HOST=your-plex-server.local
PLEX_PORT=32400
PLEX_TOKEN=your-plex-token-here
PLEX_SSL=false
```

#### 4. Usage in Rails
```ruby
# In controllers, models, or services
class MediaController < ApplicationController
  def index
    @libraries = Plex.server.libraries
  end
end

# In background jobs
class PlexSyncJob < ApplicationJob
  def perform
    movies = Plex.server.libraries.first.all
    # Process movies...
  end
end
```

### Reconfiguring After Initialization

You can update configuration at runtime, which is useful for Rails applications with multiple Plex servers or dynamic configuration:

```ruby
# Method 1: Reconfigure and reset
Plex.configure do |config|
  config.plex_host = 'new-server.local'
  config.plex_token = 'new-token'
end
Plex.reset!  # Clear cached server instance

# Method 2: Update server directly (requires all settings)
new_settings = {
  plex_host: 'new-server.local',
  plex_port: 32400,
  plex_token: 'new-token',
  ssl: false
}
Plex.update_server(new_settings)

# Method 3: Access current configuration
config = Plex.configuration
config.plex_host = 'updated-server.local'
Plex.reset!  # Reset to pick up changes
```

### Configuration Priority

Configuration is loaded in this order (later sources override earlier ones):

1. Default values
2. `~/.rubyplex.yml` file (if it exists)
3. Ruby configuration blocks (`Plex.configure`)
4. Runtime updates

## Authentication (PIN-based)

RubyPlex provides PIN-based authentication through the `Plex::Auth` module:

```ruby
# Request a new PIN
pin_response = Plex::Auth.request_pin
puts "Visit https://plex.tv/link and enter code: #{pin_response['code']}"

# Poll for validation
loop do
  result = Plex::Auth.validate_pin(pin_response)
  break if result[:token] || result[:expired]
  sleep 1
end

if result[:token]
  puts "Authenticated!"
  settings = Plex::Auth.get_server_settings(token: result[:token])
else
  puts "PIN expired before authentication"
end
```

## Usage Examples

```ruby
# Initialize connection
server = Plex.server

# Access libraries
libraries = server.libraries

# Get all movies
movies = libraries.movies

# Get TV shows
shows = libraries.shows

# Access specific show and its episodes
show = shows.first
episodes = show.episodes

# List all episode titles for the first show
episodes.each do |episode|
  puts episode.title
end

# Get a hash representation of a movie
movie_hash = movies.first.hash
puts movie_hash
```

## Working with Movie Objects

A `Movie` object represents a single movie in your Plex library. You can access its attributes and related media easily:

```ruby
# Get the first movie from your library
movie = movies.first

# Access movie attributes
puts "Title: #{movie.title}"
puts "Year: #{movie.year}"
puts "Summary: #{movie.summary}"
puts "Genres: #{movie.genre.join(', ')}"
puts "Directors: #{movie.director.join(', ')}"
puts "Duration (minutes): #{movie.duration / 60}"
puts "Rating: #{movie.rating}"

# Get a hash representation of the movie
movie_hash = movie.hash
puts movie_hash
```

A sample `movie.hash` might look like:

```ruby
{
  "title" => "Inception",
  "year" => 2010,
  "summary" => "A thief who steals corporate secrets through the use of dream-sharing technology...",
  "genre" => ["Action", "Science Fiction"],
  "director" => ["Christopher Nolan"],
  "duration" => 8880, # seconds
  "rating" => 8.8,
  # ...other attributes...
}
```

## Accessing Media and File Information

Each `Movie` object can have one or more `Media` objects, representing different versions or encodings of the movie. You can access them like this:

```ruby
# Get the media objects for a movie
media_list = movie.media

media_list.each do |media|
  puts "Media ID: #{media.id}"
  puts "Container: #{media.container}" # e.g., 'mp4', 'mkv'
  puts "Video Codec: #{media.video_codec}"
  puts "Audio Codec: #{media.audio_codec}"
  puts "Resolution: #{media.width}x#{media.height}"
  puts "Bitrate: #{media.bitrate}"

  # Each media can have one or more parts (files)
  media.parts.each do |part|
    puts "File Path: #{part.file}"
    puts "Size (bytes): #{part.size}"
    puts "Duration (seconds): #{part.duration}"
  end
end
```

A sample `Media` and `Part` might look like:

```ruby
# media.hash
{
  "id" => 12345,
  "container" => "mp4",
  "video_codec" => "h264",
  "audio_codec" => "aac",
  "width" => 1920,
  "height" => 1080,
  "bitrate" => 8000000,
  # ...other attributes...
}

# part.hash
{
  "file" => "/Volumes/Media/Movies/Inception (2010)/Inception.mp4",
  "size" => 7340032000,
  "duration" => 8880,
  # ...other attributes...
}
```

This allows you to:
- List all available media versions for a movie
- Find the exact file path on disk
- Inspect technical details like codecs, resolution, and bitrate
- Access all metadata provided by Plex for both the movie and its media files

## Logging

RubyPlex includes built-in logging with custom formatting and configurable output:

### Basic Logging Configuration

```ruby
Plex.configure do |config|
  config.log_level = :debug
  config.logger = Logger.new('plex.log')
end

# Or set log level directly
Plex.log_level = :info
```

### Log Levels and Output

RubyPlex uses custom symbols for different log levels:
- `→` Info messages
- `!` Warning messages  
- `✗` Error messages
- `•` Debug messages

### Rails Integration

In Rails applications, you can integrate with the Rails logger:

```ruby
# In config/initializers/rubyplex.rb
Plex.configure do |config|
  config.logger = Rails.logger
  config.log_level = Rails.env.production? ? :warn : :debug
end
```

### Logging Examples

```ruby
Plex.logger.info "Connecting to Plex server"
Plex.logger.warn "Server response was slow"
Plex.logger.error "Failed to authenticate"
Plex.logger.debug "Raw API response: #{response}"
```

Output:
```
→ Connecting to Plex server
! Server response was slow
✗ Failed to authenticate
• Raw API response: {...}
```

## Testing

RubyPlex uses Minitest, WebMock, and Mocha for testing. To run tests:

```bash
bundle exec rake test
```

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

This gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

