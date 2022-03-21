# frozen_string_literal: true

class ExamplePfff
  include PrettyFeed::PfTf.new
end

class ExamplePfffColors
  include PrettyFeed::PfTf.new(truthy: "cyan", falsey: "yellow")
end
