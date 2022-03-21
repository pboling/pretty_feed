# frozen_string_literal: true

RSpec.describe PrettyFeed::PfTf do
  subject(:pftfer) { ExamplePfff.new }
  shared_examples_for "ptft call" do
    it "#pftf returns nil when truthy" do
      expect(pftfer.pftf("hi: ", true)).to be_nil
    end
    it "#pftf returns nil when falsey" do
      expect(pftfer.pftf("hi: ", false)).to be_nil
    end
    it "#pftf includes prefix when truthy" do
      str = "hi: "
      output = capture(:stdout) { pftfer.pftf(str, true) }
      expect(output).to match(str)
    end
    it "#pftf includes prefix when falsey" do
      str = "hi: "
      output = capture(:stdout) { pftfer.pftf(str, false) }
      expect(output).to match(str)
    end
  end

  it_behaves_like "ptft call"
  it "#pftf has output when falsey" do
    if COMPAT_LIB.nil?
      output = capture(:stderr) { pftfer.pftf("hi: ", false) }
      expect(output).to eq("String 'hi: false' doesn't respond to red\n")
    elsif COMPAT_LIB == :cs
      output = capture(:stdout) { pftfer.pftf("hi: ", false) }
      expect(output).to eq("\e[0;31;49mhi: false\e[0m\n")
    else
      output = capture(:stdout) { pftfer.pftf("hi: ", false) }
      expect(output).to eq("\e[1;31mhi: false\e[0m\n")
    end
  end
  it "#pftf has output when truthy" do
    if COMPAT_LIB.nil?
      output = capture(:stderr) { pftfer.pftf("hi: ", true) }
      expect(output).to eq("String 'hi: true' doesn't respond to green\n")
    elsif COMPAT_LIB == :cs
      output = capture(:stdout) { pftfer.pftf("hi: ", true) }
      expect(output).to eq("\e[0;32;49mhi: true\e[0m\n")
    else
      output = capture(:stdout) { pftfer.pftf("hi: ", true) }
      expect(output).to eq("\e[1;32mhi: true\e[0m\n")
    end
  end

  context "when custom color" do
    subject(:pftfer) { ExamplePfffColors.new }
    it_behaves_like "ptft call"
    it "#pftf has output when falsey" do
      if COMPAT_LIB.nil?
        output = capture(:stderr) { pftfer.pftf("hi: ", false) }
        expect(output).to eq("String 'hi: false' doesn't respond to yellow\n")
      elsif COMPAT_LIB == :cs
        output = capture(:stdout) { pftfer.pftf("hi: ", false) }
        expect(output).to eq("\e[0;33;49mhi: false\e[0m\n")
      else
        output = capture(:stdout) { pftfer.pftf("hi: ", false) }
        expect(output).to eq("\e[1;33mhi: false\e[0m\n")
      end
    end
    it "#pftf has output when truthy" do
      if COMPAT_LIB.nil?
        output = capture(:stderr) { pftfer.pftf("hi: ", true) }
        expect(output).to eq("String 'hi: true' doesn't respond to cyan\n")
      elsif COMPAT_LIB == :cs
        output = capture(:stdout) { pftfer.pftf("hi: ", true) }
        expect(output).to eq("\e[0;36;49mhi: true\e[0m\n")
      else
        output = capture(:stdout) { pftfer.pftf("hi: ", true) }
        expect(output).to eq("\e[1;35mhi: true\e[0m\n")
      end
    end
  end
end
