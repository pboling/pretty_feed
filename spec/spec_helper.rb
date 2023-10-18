# frozen_string_literal: true

# External gems
require "version_gem/rspec"
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

# RSpec Configs
require "config/rspec/rspec_core"
require "config/rspec/silent_stream"

# Load SimpleCov config
require "kettle/soup/cover"

# This gem
require "pretty_feed"

# Support Files
require "support/example_classes"
