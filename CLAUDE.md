# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

RubyPlex is a Ruby gem for interacting with the Plex Media Server HTTP API. It provides authentication via PIN-based flow, media library browsing, and server management through a simple Ruby interface.

## Common Commands

### Testing
- Run all tests: `bundle exec rake test` or `bundle exec rake`
- Run specific test file: `bundle exec ruby test/movie_test.rb`
- Test files are located in the `test/` directory and use Minitest framework

### Development
- Install dependencies: `bundle install`
- Build gem: `bundle exec rake build`
- Release gem: `bundle exec rake release`

## Architecture

### Core Module Structure
- `Plex` - Main module with configuration and server access
- `Plex.configure` - Configuration block for setting up connection parameters
- `Plex.configuration` - Access to current configuration without yielding
- `Plex.server` - Primary entry point that returns a configured Server instance
- `Plex.reset!` - Clears cached configuration and server instances
- `Plex.update_server(settings)` - Updates server with new settings hash

### Key Components

**Authentication (`lib/plex/auth.rb`)**
- PIN-based authentication flow with Plex.tv
- Methods: `request_pin`, `validate_pin`, `get_servers`, `get_server_settings`
- Handles OAuth-style authentication without requiring user credentials

**Server (`lib/plex/server.rb`)**
- Main interface for querying Plex server
- Handles HTTP requests with HTTParty
- Advanced query parameter parsing with operator support (>=, <=, >, <, !=)
- Manual URL building to preserve operators in query strings
- Comprehensive error handling with Plex::Error exceptions
- Enhanced pagination and query parameters
- Key methods: `libraries`, `library`, `query`, `build_query_url`

**Configuration (`lib/plex/configuration.rb`)**
- Loads settings from `~/.rubyplex.yml` or Ruby blocks
- Required settings: `plex_host`, `plex_port`, `plex_token`, `ssl`
- Includes custom logger formatting with symbols (→, !, ✗, •)
- Error handling for YAML file loading with fallback logging
- Automatic logger format setting when logger is changed
- Supports Rails integration via initializers and environment variables

**Base Class (`lib/plex/base.rb`)**
- Shared functionality for all Plex objects
- Automatic method delegation to hash attributes with camelCase conversion
- Time/date attribute transformation
- Tag value extraction for arrays like Genre, Director, etc.

**Media Hierarchy**
- `Library` - Represents media libraries (movies/shows) with advanced filtering
- `Movie`/`Show` - Individual media items
- `Episode` - TV show episodes
- `Media`/`Part` - File and encoding information
- `Stream` - Individual audio/video/subtitle streams

**Query System**
- Supports 16+ query parameters including technical specs and metadata
- Operator-based filtering: `'updatedAt>=' => '2025-08-01'`
- Multiple filter combinations with sorting and pagination
- No result caching - all queries return fresh data

### Data Flow
1. Configuration loads from YAML or Ruby block
2. Server instance created with HTTParty for HTTP requests
3. Authentication via PIN flow provides access token
4. Libraries queried to get media collections
5. Media objects created with automatic attribute mapping
6. Nested relationships (show → episodes, movie → media → parts)

### Testing Setup
- Uses Minitest with WebMock for HTTP stubbing
- Test fixtures in `test/fixtures/` (JSON responses)
- Mocha for method stubbing
- Network connections disabled in tests via WebMock

### Key Patterns
- No caching of library results - all queries return fresh data
- Consistent use of hash-based initialization across all classes
- Automatic snake_case to camelCase conversion for Plex API compatibility
- Advanced query parameter parsing with regex-based operator detection
- Manual URL construction to preserve query operators
- Centralized logging through `Plex.logger` with custom formatting