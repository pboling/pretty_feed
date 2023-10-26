# frozen_string_literal: true

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
require "config/byebug"
require "config/rspec/rspec_block_is_expected"
require "config/rspec/rspec_core"
require "config/rspec/silent_stream"
require "config/rspec/version_gem"

# Load SimpleCov config
require "kettle-soup-cover"

# Last thing before loading this gem!
require "simplecov" if Kettle::Soup::Cover::DO_COV

# Finally, this gem
require "pretty_feed"

# Support Files (but only the ones that can't be loaded before the gem is loaded)
require "support/example_classes"
