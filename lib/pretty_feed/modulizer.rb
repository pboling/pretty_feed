# frozen_string_literal: true

module PrettyFeed
  # Provides the pf (print_feed) method
  module Modulizer
    def to_mod(truthy:, falsey:)
      Module.new do
        define_method(:pftf) do |prefix = nil, value = "", proc = nil|
          cvalue = if proc.nil?
                     value
                   else
                     proc.respond_to?(:call) ? proc.call(value) : proc
                   end
          color = cvalue ? truthy : falsey
          puts PrettyFeed::Compat["#{prefix}#{value}", color].send(color)
        end
      end
    end

    module_function :to_mod
  end
end
