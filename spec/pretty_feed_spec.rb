# frozen_string_literal: true

RSpec.describe PrettyFeed do
  it "provides a namespace" do
    expect(described_class).to be_a(Module)
  end
end
