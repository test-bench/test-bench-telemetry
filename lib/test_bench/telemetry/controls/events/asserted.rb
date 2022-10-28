module TestBench
  class Telemetry
    module Controls
      module Events
        module Asserted
          def self.example(result: nil, path: nil, line_number: nil, time: nil)
            result ||= self.result
            path ||= self.path
            line_number ||= self.line_number
            time ||= self.time

            TestBench::Telemetry::Event::Asserted.new(result, path, line_number, time)
          end

          def self.random
            result = Result.random
            path = Path.random
            line_number = LineNumber.random
            time = Time.random

            example(result:, path:, line_number:, time:)
          end

          def self.result = Result.example
          def self.path = Path.example
          def self.line_number = LineNumber.example
          def self.time = Time.example
        end
      end
    end
  end
end
