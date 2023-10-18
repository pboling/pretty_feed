# frozen_string_literal: true

# Get the GEMFILE_VERSION without *require* "my_gem/version", for code coverage accuracy
# See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-825171399
load "lib/pretty_feed/version.rb"
gem_version = PrettyFeed::Version::VERSION
PrettyFeed::Version.send(:remove_const, :VERSION)

Gem::Specification.new do |spec|
  spec.name = "pretty_feed"
  spec.version = gem_version
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

  # Utilities
  spec.add_dependency("version_gem", "~> 1.1", ">= 1.1.3")
  spec.add_development_dependency("rake", "~> 13.0")

  # Code Coverage
  spec.add_development_dependency("kettle-soup-cover", "~> 0.1")

  # Documentation
  spec.add_development_dependency("rbs", "~> 3.1")
  spec.add_development_dependency("redcarpet", "~> 3.6")
  spec.add_development_dependency("yard", "~> 0.9", ">= 0.9.34")
  spec.add_development_dependency("yard-junk", "~> 0.0")

  # Linting
  spec.add_development_dependency("rubocop-lts", "~> 16.1", ">= 16.1.1")
  spec.add_development_dependency("rubocop-packaging", "~> 0.5", ">= 0.5.2")
  spec.add_development_dependency("rubocop-rspec", "~> 2.24")

  # Testing
  spec.add_development_dependency("rspec", "~> 3.12")
  spec.add_development_dependency("rspec-benchmark", "~> 0.6")
  spec.add_development_dependency("rspec-block_is_expected", "~> 1.0", ">= 1.0.5")
  spec.add_development_dependency("rspec_junit_formatter", "~> 0.6")
  spec.add_development_dependency("rspec-stubbed_env", "~> 1.0", ">= 1.0.1")
  spec.add_development_dependency("silent_stream", "~> 1")
end
