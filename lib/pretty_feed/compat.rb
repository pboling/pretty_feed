# frozen_string_literal: true

module PrettyFeed
  # Provide compatibility with Polluted and Unpolluted Strings
  module Compat
    define_method(:[]) do |str, color|
      return ColorizedString[str] if defined?(ColorizedString)
      return str if str.respond_to?(color.to_sym)

      dstr = str.dup
      dstr.singleton_class.send(:include, color_stub(str, color))
      dstr
    end
    module_function :[]

    private

    def color_stub(str, color)
      Module.new do
        define_method(color.to_sym) do
          warn "String '#{str}' doesn't respond to #{color}; adding stub"
          self
        end
      end
    end
    module_function :color_stub
  end
end
