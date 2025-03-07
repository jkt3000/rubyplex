# RubyPlex

A Ruby gem for interacting with the Plex Media Server HTTP API.

## Overview

RubyPlex provides a simple, intuitive interface to interact with your Plex Media Server. Built with Ruby best practices, it offers an easy way to access and manage your Plex media libraries programmatically.

## Features

- Simple configuration via YAML or Ruby code
- Access to Plex libraries, movies, TV shows, and episodes
- Native Ruby object mapping for Plex resources

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

Configure RubyPlex using either method:

### YAML Configuration
Create `~/.rubyplex.yml`:

```yaml
plex_host: 'localhost'
plex_port: 32400
plex_token: 'your-plex-token'
ssl: false
```
or 
```yaml
PLEX_HOST: 'localhost'
PLEX_PORT: 32400
PLEX_TOKEN: 'your-plex-token'
SSL: false
```


### Ruby configuration

```ruby
# Configure with block
Plex.configure do |config|
  config.plex_host = 'localhost'
  config.plex_port = 32400
  config.plex_token = 'your-token'
  config.ssl = false
  config.log_level = :info
end

# Initialize server
server = Plex.server

# set log level
Plex.log_level = :debug | :warn | :info

# Access libraries
libraries = server.libraries

# Initialize connection
server = Plex.server

# Access libraries
libraries = server.libraries

# Get all movies
movies = libraries.movies

# List all movie titles
movies.each do |movie|
  puts movie.title
end

# Get TV shows
shows = libraries.shows

# List all show titles
shows.each do |show|
  puts show.title
end

# Access specific show
show = shows.first
episodes = show.episodes

# List all episode titles for the first show
episodes.each do |episode|
  puts episode.title
end

# Use the .hash method to get a hash representation of a movie
movie_hash = movies.first.hash
puts movie_hash
```
## Authentication

RubyPlex provides PIN-based authentication through the Plex::Auth module:

```ruby
# Request a new PIN
pin_response = Plex::Auth.request_pin
# => {
#      "id" => "12345",
#      "code" => "ABCD",
#      "expiresAt" => "2024-03-07T17:52:05Z",
#      "authToken" => nil,
#      "qr" => "https://plex.tv/api/v2/pins/qr/ABCD"
#    }

# Visit https://plex.tv/link and enter the PIN code
puts "Please visit https://plex.tv/link and enter code: #{pin_response['code']}"

# Check PIN validation status
result = Plex::Auth.validate_pin(pin_response)
# => {
#      token: "your-auth-token",  # nil if not yet validated
#      expired: false
#    }

# Once you have a valid token, get server settings
settings = Plex::Auth.get_server_settings(token: result[:token])
# => [{
#      plex_host: "192.168.1.100",
#      plex_port: 32400,
#      plex_token: "server-access-token",
#      ssl: false
#    }]

# Configure Plex with the first server's settings
Plex.update_server(settings[0]) # or whichever config you want to use
```

You can also create a loop to wait for PIN validation:

```ruby
pin_response = Plex::Auth.request_pin
puts "Visit https://plex.tv/link and enter code: #{pin_response['code']}"

loop do
  result = Plex::Auth.validate_pin(pin_response)
  break if result[:token] || result[:expired]
  sleep 1
end

if result[:token]
  puts "Successfully authenticated!"
  settings = Plex::Auth.get_server_settings(token: result[:token])
else
  puts "PIN expired before authentication"
end
```


## Development

After checking out the repo, run:

```bash
bundle install
```

Run tests with:

```bash
rake test
```

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

This gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

