# frozen_string_literal: true

module PrettyFeed
  # Provide compatibility with Polluted and Unpolluted Strings
  module Compat
    module_function

    define_method(:[]) do |str, color|
      if defined?(ColorizedString)
        ColorizedString[str]
      elsif str.respond_to?(color.to_sym)
        str
      else
        mod = Module.new do
          define_method(color.to_sym) do
            warn "String '#{self}' doesn't respond to #{color}; adding stub"
            self
          end
        end

        dstr = str.dup
        dstr.singleton_class.send(:include, mod)
        dstr
      end
    end
  end
end
