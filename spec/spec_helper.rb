# frozen_string_literal: true

# External gems
require "version_gem/rspec"
require "silent_stream"
require "byebug" if ENV.fetch("DEBUG", "false").casecmp?("true")

compat_lib = begin
  require "awesome_print"
  puts "Testing with awesome_print".cyan
  :ap
rescue LoadError # rubocop:disable Lint/SuppressedException
end || begin
  require "colored2"
  puts "Testing with colored2".cyan
  :c2
rescue LoadError # rubocop:disable Lint/SuppressedException
end || begin
  require "colorized_string"
  puts ColorizedString["Testing with colorized_string"].cyan
  :cs
rescue LoadError # rubocop:disable Lint/SuppressedException
end || begin
  require "term-ansicolor"
  class String
    include Term::ANSIColor
  end
  puts "Testing with term-ansicolor".cyan
  :ta
rescue LoadError # rubocop:disable Lint/SuppressedException
end

COMPAT_LIB = compat_lib

# RSpec Configs
require "config/rspec/rspec_block_is_expected"
require "config/rspec/rspec_core"
require "config/rspec/silent_stream"

# Load SimpleCov config
require "kettle/soup/cover"

# This gem
require "pretty_feed"

# Support Files
require "support/example_classes"
