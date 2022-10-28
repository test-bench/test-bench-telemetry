module TestBench
  class Telemetry
    module Controls
      module Events
        module TestFinished
          def self.example(result: nil, title: nil, time: nil)
            result ||= self.result
            time ||= self.time

            if title == :none
              title = nil
            else
              title ||= self.title
            end

            TestBench::Telemetry::Event::TestFinished.new(result, title, time)
          end

          def self.random
            result = Result.random
            title = Title::Test.random
            time = Time.random

            example(result:, title:, time:)
          end

          def self.result = Result.example
          def self.title = Title::Test.example
          def self.time = Time.example
        end
      end
    end
  end
end
