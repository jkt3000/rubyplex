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
config = {
  plex_host: 'localhost'
  plex_port: 32400
  plex_token: 'your-plex-token'
  ssl: false
}
server = Plex::Server.new(config)
```

## Usage

```ruby

# settings log level
Plex.logger.set_level('DEBUG')

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

