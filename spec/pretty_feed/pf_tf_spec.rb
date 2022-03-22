# frozen_string_literal: true

RSpec.describe PrettyFeed::PfTf do
  subject(:pftfer) { ExamplePfff.new }
  shared_examples_for "ptft call" do
    it "#pftf returns nil when truthy" do
      expect(pftfer.pftf("bean: ", true)).to be_nil
    end
    it "#pftf returns nil when proc is truthy" do
      expect(pftfer.pftf("rake: ", true, ->(a) { !a.nil? })).to be_nil
    end
    it "#pftf returns nil when falsey" do
      expect(pftfer.pftf("leaf: ", false)).to be_nil
    end
    it "#pftf returns nil when proc is falsey" do
      expect(pftfer.pftf("pasta: ", true, ->(a) { !a })).to be_nil
    end
    it "#pftf includes prefix when truthy" do
      str = "pear: "
      output = capture(:stdout) { pftfer.pftf(str, true) }
      expect(output).to match(str)
    end
    it "#pftf includes prefix when proc is truthy" do
      str = "banana: "
      value = 123
      output = capture(:stdout) { pftfer.pftf(str, value, ->(a) { !a.nil? }) }
      expect(output).to match(str)
      expect(output).to match(value.to_s)
    end
    it "#pftf includes prefix when falsey" do
      str = "orange: "
      output = capture(:stdout) { pftfer.pftf(str, false) }
      expect(output).to match(str)
    end
    it "#pftf includes prefix when proc is falsey" do
      str = "apple: "
      value = 123
      output = capture(:stdout) { pftfer.pftf(str, value, ->(a) { !a }) }
      expect(output).to match(str)
      expect(output).to match(value.to_s)
    end
  end

  it_behaves_like "ptft call"
  it "#pftf has output when falsey" do
    str = "hurd: "
    value = false
    output = capture(:stderr) { pftfer.pftf(str, value) }
    if COMPAT_LIB.nil?
      expect(output).to eq("String 'hurd: false' doesn't respond to red; adding stub\n")
    else
      expect(output).to match(/\\e\[.*\d{2}m#{str}#{value}\\e\[0m\\n/)
    end
  end
  it "#pftf has output when truthy" do
    str = "boo: "
    value = true
    output = capture(:stderr) { pftfer.pftf(str, value) }
    if COMPAT_LIB.nil?
      expect(output).to eq("String 'boo: true' doesn't respond to green; adding stub\n")
    else
      expect(output).to match(/\\e\[.*\d{2}m#{str}#{value}\\e\[0m\\n/)
    end
  end

  context "when custom color" do
    subject(:pftfer) { ExamplePfffColors.new }
    it_behaves_like "ptft call"
    it "#pftf has output when falsey" do
      str = "burst: "
      value = false
      output = capture(:stderr) { pftfer.pftf(str, value) }
      if COMPAT_LIB.nil?
        expect(output).to eq("String 'burst: false' doesn't respond to yellow; adding stub\n")
      else
        expect(output).to match(/\\e\[.*\d{2}m#{str}#{value}\\e\[0m\\n/)
      end
    end
    it "#pftf has output when truthy" do
      str = "shoe: "
      value = true
      output = capture(:stderr) { pftfer.pftf(str, value) }
      if COMPAT_LIB.nil?
        expect(output).to eq("String 'shoe: true' doesn't respond to cyan; adding stub\n")
      else
        expect(output).to match(/\\e\[.*\d{2}m#{str}#{value}\\e\[0m\\n/)
      end
    end
  end
end
