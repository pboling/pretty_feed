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
  let(:not_a_proc_truthy) { capture(caught) { pftfer.pftf(str, falsey_value, truthy_value) } }
  let(:not_a_proc_falsey) { capture(caught) { pftfer.pftf(str, truthy_value, falsey_value) } }
  let(:truthy_color) { :green }
  let(:falsey_color) { :red }
  let(:ansi_term_colors) {
    {
      black: 30,
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      magenta: 35,
      cyan: 36,
      white: 37,
      default: 39,
      light_black: 90,
      light_red: 91,
      light_green: 92,
      light_yellow: 93,
      light_blue: 94,
      light_magenta: 95,
      light_cyan: 96,
      light_white: 97,
    }
  }

  before(:all) do # rubocop:disable RSpec/BeforeAfterAll
    if COMPAT_LIB
      puts "TESTING WITH COMPAT_LIB: #{COMPAT_LIB}, WILL CAPTURE :stdout"
    else
      puts "TESTING WITH NO COMPAT_LIB, WILL CAPTURE :stderr"
    end
  end

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

    it "#pftf truthy non-callable 3rd arg acts as color switch override" do
      if COMPAT_LIB.nil?
        expect(not_a_proc_truthy).to match("'#{str}#{falsey_value}'.#{truthy_color}")
      else
        expect(not_a_proc_truthy.split(ansi_term_colors[truthy_color].to_s)[1]).to match("#{str}#{falsey_value}")
      end
    end

    it "#pftf falsey non-callable 3rd arg acts as color switch override" do
      if COMPAT_LIB.nil?
        expect(not_a_proc_falsey).to match("'#{str}#{truthy_value}'.#{falsey_color}")
      else
        expect(not_a_proc_falsey.split(ansi_term_colors[falsey_color].to_s)[1]).to match("#{str}#{truthy_value}")
      end
    end

    context "without rescue_logged errors" do
      subject(:op) { out_proc }

      let(:reraise) { false }
      let(:backtrace_logged) { false }
      let(:array) { [] }
      let(:captured_out_proc) { capture(caught) { out_proc } }
      let(:out_proc) {
        pftfer.pftf(
          str,
          truthy_value,
          ->(a) { !a.nil? },
        ) {
          array << 1
          raise ArgumentError, "Gonna Have a Bad Time"
        }
      }

      context "with error" do
        it "#pftf raises error" do
          block_is_expected.to raise_error(ArgumentError, "Gonna Have a Bad Time") &
            # runs block has to be tested with check for raise error
            change { array[0] }.from(nil).to(1)
        end
      end

      context "without error" do
        let(:benchmark) { false }
        let(:out_proc) {
          pftfer.pftf(
            str,
            truthy_value,
            ->(a) { !a.nil? },
            benchmark: benchmark,
          ) { array << 1 }
        }

        it "#pftf raises no error" do
          block_is_expected.to not_raise_error
        end

        it "runs the block" do
          block_is_expected.to change { array[0] }.from(nil).to(1)
        end

        it "has output" do
          expect(captured_out_proc).to match(%r{\[BEG\] pear: cake}) &
            match(%r{\[FIN\] pear: cake})
        end

        context "with benchmark" do
          let(:benchmark) { true }

          it "has output" do
            expect(captured_out_proc).to match(%r{\[BEG\] pear: cake}) &
              match(%r{\[FIN\]\[\d+.\d{4}s\] pear: cake})
          end
        end
      end
    end

    context "with rescue_logged errors" do
      subject(:rop) { rescued_out_proc }

      let(:reraise) { false }
      let(:backtrace_logged) { false }
      let(:rescue_logged) { ArgumentError }
      let(:array) { [] }
      let(:captured_rescued_out_proc) { capture(caught) { rescued_out_proc } }
      let(:rescued_out_proc) {
        pftfer.pftf(
          str,
          truthy_value,
          ->(a) { !a.nil? },
          rescue_logged: rescue_logged,
          reraise: reraise,
          backtrace_logged: backtrace_logged,
        ) {
          array << 1
          raise ArgumentError, "Gonna Have a Bad Time"
        }
      }

      context "without backtrace" do
        context "with reraise" do
          let(:reraise) { true }

          it "#pftf reraises error" do
            block_is_expected.to raise_error(ArgumentError, "Gonna Have a Bad Time") &
              # runs block has to be tested with check for raise error
              change { array[0] }.from(nil).to(1)
          end
        end

        context "with no reraise" do
          it "#pftf does not reraise error" do
            block_is_expected.to not_raise_error
          end

          it "runs block" do
            block_is_expected.to change { array[0] }.from(nil).to(1)
          end

          it "outputs no backtrace" do
            expect(captured_rescued_out_proc).not_to match(%r{\[ERR\]\[Backtrace\]})
          end
        end
      end

      context "with backtrace" do
        let(:backtrace_logged) { true }

        context "with reraise" do
          let(:reraise) { true }

          it "#pftf reraises error" do
            block_is_expected.to raise_error(ArgumentError, "Gonna Have a Bad Time") &
              # runs block has to be tested with check for raise error
              change { array[0] }.from(nil).to(1)
          end
        end

        context "with no reraise" do
          it "#pftf does not reraise error" do
            block_is_expected.to not_raise_error
          end

          it "runs block" do
            block_is_expected.to change { array[0] }.from(nil).to(1)
          end

          it "outputs backtrace" do
            expect(captured_rescued_out_proc).to match(%r{\[ERR\]\[Backtrace\]})
          end
        end
      end
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
