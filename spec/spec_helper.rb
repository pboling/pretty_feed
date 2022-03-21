# frozen_string_literal: true

require "silent_stream"
compat_lib = begin
  require "awesome_print"
  puts "Testing with awesome_print"
  :ap
rescue LoadError # rubocop:disable Lint/SuppressedException
end || begin
  require "colored2"
  puts "Testing with colored2"
  :c2
rescue LoadError # rubocop:disable Lint/SuppressedException
end || begin
  require "colorized_string"
  puts "Testing with colorized_string"
  :cs
rescue LoadError # rubocop:disable Lint/SuppressedException
end

COMPAT_LIB = compat_lib
DEBUG = ENV["DEBUG"] == "true"
RUN_COVERAGE = ENV["CI_CODECOV"] || ENV["CI"].nil?

ruby_version = Gem::Version.new(RUBY_VERSION)
minimum_version = ->(version, engine = "ruby") { ruby_version >= Gem::Version.new(version) && RUBY_ENGINE == engine }
coverage = minimum_version.call("2.7") && RUN_COVERAGE
debugging = minimum_version.call("2.7") && DEBUG

if DEBUG
  if debugging
    require "byebug"
  elsif minimum_version.call("2.7", "jruby")
    require "pry-debugger-jruby"
  end
end

require "simplecov" if coverage

# This gem
require "pretty_feed"

# RSpec Configs
require "config/rspec/rspec_core"
require "config/rspec/silent_stream"

# Support Files
require "support/example_classes"
