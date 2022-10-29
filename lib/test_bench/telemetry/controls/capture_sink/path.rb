module TestBench
  class Telemetry
    module Controls
      module CaptureSink
        module Path
          def self.example(segments=nil)
            segments ||= Segment.examples

            segments = segments.dup

            path = TestBench::Telemetry::Sink::Capture::Path.new
            path.segments = segments
            path
          end

          module Segment
            def self.examples
              [example, Context.other_example, Test.example]
            end

            def self.example = Context.example

            Test = Title::Test
            Context = Title::Context
          end
        end
      end
    end
  end
end
