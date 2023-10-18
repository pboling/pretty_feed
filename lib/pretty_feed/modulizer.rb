# frozen_string_literal: true

# Std Libs
require "benchmark"

module PrettyFeed
  # Provides the pf (print_feed) method
  module Modulizer
    def to_mod(truthy:, falsey:)
      Module.new do
        define_method(:pftf) do |msg = nil, value = "", proc = nil, **options, &block|
          rescue_logged = Array(options[:rescue_logged])
          cvalue = if proc.nil?
            value
          else
            proc.respond_to?(:call) ? proc.call(value) : proc
          end
          color = cvalue ? truthy : falsey
          if block
            external_block =
              if rescue_logged.any?
                -> () {
                  begin
                    block.call
                  rescue *rescue_logged => error
                    puts PrettyFeed::Compat["[ERR][#{error.class}][#{error.message}] #{msg}#{value}", color].send(color)
                    puts PrettyFeed::Compat["[ERR][Backtrace]\n#{error.backtrace.join("\n")}", color].send(color) if options[:backtrace_logged]
                    raise error if options[:reraise]
                  end
                }
              else
                block
              end
            puts PrettyFeed::Compat["[BEG] #{msg}#{value}", color].send(color)
            if options[:benchmark]
              time = Benchmark.realtime do
                external_block.call
              end
              seconds = "%.4fs" % time
              puts PrettyFeed::Compat["[FIN][#{seconds}] #{msg}#{value}", color].send(color)
            else
              external_block.call
              puts PrettyFeed::Compat["[FIN] #{msg}#{value}", color].send(color)
            end
          else
            puts PrettyFeed::Compat["#{msg}#{value}", color].send(color)
          end
        end
      end
    end

    module_function :to_mod
  end
end
