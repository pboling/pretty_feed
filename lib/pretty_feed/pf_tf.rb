# frozen_string_literal: true

module PrettyFeed
  # Pretty Feed Truthy Falsey
  #
  # Usage in a rake task, for example:
  #
  #   namespace :scrub do
  #     task :blurb => :environment do |_t, args|
  #       include PrettyFeed::PfTf.new(truthy: 'green', falsey: 'blue')
  #       pf("this will be green", true)
  #       # => "this will be green" # but in green
  #       pf("this will be blue", false)
  #       # => "this will be blue" # but in blue
  #     end
  #   end
  #
  class PfTf < Module
    def initialize(truthy: "green", falsey: "red")
      # Ruby's Module initializer doesn't take any arguments
      super()
      @truthy = truthy
      @falsey = falsey
    end

    def included(base)
      modulizer = Modulizer.to_mod(truthy: @truthy, falsey: @falsey)
      base.send(:prepend, modulizer)
    end
  end
end
