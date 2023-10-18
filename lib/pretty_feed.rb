# frozen_string_literal: true

# External gems
require "version_gem"

# This library
require_relative "pretty_feed/version"
require_relative "pretty_feed/compat"
require_relative "pretty_feed/modulizer"
require_relative "pretty_feed/pf_tf"

# Namespace for this library
module PrettyFeed
end

PrettyFeed::Version.class_eval do
  extend VersionGem::Basic
end
