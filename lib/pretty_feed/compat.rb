# frozen_string_literal: true

module PrettyFeed
  # Provide compatibility with Polluted and Unpolluted Strings
  module Compat
    define_method(:[]) do |str, color|
      return ColorizedString[str] if defined?(ColorizedString)
      return str if str.respond_to?(color.to_sym)

      dstr = str.dup
      if defined?(Term::ANSIColor)
        dstr.singleton_class.send(:include, Term::ANSIColor)
      else
        dstr.singleton_class.send(:include, color_stub(str, color))
      end
      dstr
    end
    module_function :[]

    private

    module_function def color_stub(str, color)
      Module.new do
        define_method(color.to_sym) do
          warn "Adding stub for missing '#{str}'.#{color}"
          self
        end
      end
    end
  end
end
