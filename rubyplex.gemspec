# frozen_string_literal: true

require_relative "lib/plex/version"

Gem::Specification.new do |spec|
  spec.name = "rubyplex"
  spec.version = Plex::VERSION
  spec.authors = ["John T"]
  spec.email = ["manjiro@gmail.com"]

  spec.summary = ": Write a short summary, because RubyGems requires one."
  spec.description = ": Write a longer description or delete this line."
  spec.homepage = "http://github.com/jkt3000/ruby_plex"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = ": Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://github.com/jkt3000/ruby_plex"
  spec.metadata["changelog_uri"] = "http://github.com/jkt3000/ruby_plex"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "httparty", "~> 0.21"

  spec.add_development_dependency "minitest",     "~> 5.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "mocha"
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
