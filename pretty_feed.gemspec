# frozen_string_literal: true

require_relative "lib/pretty_feed/version"

Gem::Specification.new do |spec|
  spec.name = "pretty_feed"
  spec.version = PrettyFeed::VERSION
  spec.authors = ["Peter Boling"]
  spec.email = ["peter.boling@gmail.com"]

  spec.summary = "Simple pass/fail logging colorization"
  spec.description = <<~DESC
    PrettyFeed provides a modulizer you can include in a job, worker, class, rake task, etc,
    which allows for simple pass/fail logging colorization.
    Defaults are `truthy: 'green'` and `falsey: 'red'`.
  DESC
  spec.homepage = "https://github.com/pboling/pretty_feed"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pboling/pretty_feed/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "https://github.com/pboling/pretty_feed/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "https://github.com/pboling/pretty_feed/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/pretty_feed/#{spec.version}"
  spec.metadata["wiki_uri"] = "https://github.com/pboling/pretty_feed/wiki"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["lib/**/*.rb",
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "README.md",
    "SECURITY.md"]
  spec.bindir = "exe"
  spec.executables = []
  spec.require_paths = ["lib"]

  spec.add_development_dependency("rake", "~> 13.0")
  spec.add_development_dependency("rspec", "~> 3.10")
  spec.add_development_dependency("rspec-benchmark", "~> 0.6")
  spec.add_development_dependency("rspec-block_is_expected", "~> 1.0")
  spec.add_development_dependency("silent_stream", "~> 1")
  spec.add_development_dependency("yard", ">= 0.9.20")

  spec.add_development_dependency("rubocop-lts", "~> 16.1", ">= 16.1.1")
end
