# frozen_string_literal: true

RSpec.describe PrettyFeed::PfTf do
  subject(:pftfer) { ExamplePfff.new }

  let(:caught) { COMPAT_LIB.nil? ? :stderr : :stdout }
  let(:str) { "pear: " }
  let(:truthy_value) { :cake }
  let(:falsey_value) { false }
  let(:color_open) { Regexp.escape("\e[") }
  let(:color_close) { Regexp.escape("\e[0m\n") }
  let(:falsey_out) { capture(caught) { pftfer.pftf(str, falsey_value) } }
  let(:truthy_out) { capture(caught) { pftfer.pftf(str, truthy_value) } }
  let(:falsey_out_proc) { capture(caught) { pftfer.pftf(str, falsey_value, ->(a) { a }) } }
  let(:truthy_out_proc) { capture(caught) { pftfer.pftf(str, truthy_value, ->(a) { !a.nil? }) } }
  let(:truthy_color) { :green }
  let(:falsey_color) { :red }

  shared_examples_for "ptft call" do
    it "#pftf returns nil when truthy" do
      expect(pftfer.pftf(str, truthy_value)).to be_nil
    end

    it "#pftf returns nil when proc is truthy" do
      expect(pftfer.pftf(str, truthy_value, ->(a) { !a.nil? })).to be_nil
    end

    it "#pftf returns nil when falsey" do
      expect(pftfer.pftf(str, falsey_value)).to be_nil
    end

    it "#pftf returns nil when proc is falsey" do
      expect(pftfer.pftf(str, falsey_value, ->(a) { !a })).to be_nil
    end

    it "#pftf includes prefix when truthy" do
      expect(truthy_out).to match("#{str}#{truthy_value}")
    end

    it "#pftf includes prefix when proc is truthy" do
      expect(truthy_out_proc).to match("#{str}#{truthy_value}")
    end

    it "#pftf includes prefix when falsey" do
      expect(falsey_out).to match("#{str}#{falsey_value}")
    end

    it "#pftf includes prefix when proc is falsey" do
      expect(falsey_out_proc).to match("#{str}#{falsey_value}")
    end

    it "#pftf has output when falsey" do
      if COMPAT_LIB.nil?
        expect(falsey_out).to eq("Adding stub for missing '#{str}#{falsey_value}'.#{falsey_color}\n")
      else
        expect(falsey_out).to match(/#{color_open}.*\d{2}m#{Regexp.escape(str.to_s)}#{Regexp.escape(falsey_value.to_s)}#{color_close}/)
      end
    end

    it "#pftf has output when falsey proc" do
      if COMPAT_LIB.nil?
        expect(falsey_out_proc).to eq("Adding stub for missing '#{str}#{falsey_value}'.#{falsey_color}\n")
      else
        expect(falsey_out_proc).to match(/#{color_open}.*\d{2}m#{Regexp.escape(str.to_s)}#{Regexp.escape(falsey_value.to_s)}#{color_close}/)
      end
    end

    it "#pftf has output when truthy" do
      if COMPAT_LIB.nil?
        expect(truthy_out).to eq("Adding stub for missing '#{str}#{truthy_value}'.#{truthy_color}\n")
      else
        expect(truthy_out).to match(/#{color_open}.*\d{2}m#{Regexp.escape(str.to_s)}#{Regexp.escape(truthy_value.to_s)}#{color_close}/)
      end
    end

    it "#pftf has output when truthy proc" do
      if COMPAT_LIB.nil?
        expect(truthy_out_proc).to eq("Adding stub for missing '#{str}#{truthy_value}'.#{truthy_color}\n")
      else
        expect(truthy_out_proc).to match(/#{color_open}.*\d{2}m#{Regexp.escape(str.to_s)}#{Regexp.escape(truthy_value.to_s)}#{color_close}/)
      end
    end
  end

  it_behaves_like "ptft call"

  context "when custom color" do
    subject(:pftfer) { ExamplePfffColors.new }

    let(:truthy_color) { :cyan }
    let(:falsey_color) { :yellow }

    it_behaves_like "ptft call"
  end
end
