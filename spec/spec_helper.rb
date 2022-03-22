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

ruby_version = Gem::Version.new(RUBY_VERSION)
minimum_version = ->(version, engine = "ruby") { ruby_version >= Gem::Version.new(version) && RUBY_ENGINE == engine }
actual_version = lambda do |major, minor|
  actual = Gem::Version.new(ruby_version)
  major == actual.segments[0] && minor == actual.segments[1] && RUBY_ENGINE == "ruby"
end
debugging = minimum_version.call("2.7") && DEBUG
RUN_COVERAGE = minimum_version.call("2.6") && (ENV['COVER_ALL'] || ENV["CI_CODECOV"] || ENV["CI"].nil?)
ALL_FORMATTERS = actual_version.call(2, 7) && (ENV['COVER_ALL'] || ENV["CI_CODECOV"] || ENV['CI'])

if DEBUG
  if debugging
    require "byebug"
  elsif minimum_version.call("2.7", "jruby")
    require "pry-debugger-jruby"
  end
end

require "simplecov" if RUN_COVERAGE

# This gem
require "pretty_feed"

# RSpec Configs
require "config/rspec/rspec_core"
require "config/rspec/silent_stream"

# Support Files
require "support/example_classes"
