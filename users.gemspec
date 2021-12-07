# frozen_string_literal: true

require_relative "lib/users/version"

Gem::Specification.new do |spec|
  spec.name          = "users"
  spec.version       = Users::VERSION
  spec.authors       = ["Nikolay Voynov"]
  spec.email         = ["nvoynov@gmail.com"]

  spec.summary       = "Cleon demo domain of users management"
  spec.description   = "See user_stories.md for details"
  spec.homepage      = "https://github.com/nvoynov/users"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nvoynov/users"
  spec.metadata["changelog_uri"] = "https://github.com/nvoynov/users/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "bcrypt", "~> 3.1.16"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
