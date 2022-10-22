module TestBench
  class Telemetry
    module Controls
      module Events
        module FixtureFinished
          def self.example(result: nil, name: nil, time: nil)
            result ||= self.result
            name ||= self.fixture_name
            time ||= self.time

            TestBench::Telemetry::Event::FixtureFinished.new(result, name, time)
          end

          def self.random
            result = Result.random
            name = FixtureName.random
            time = Time.random

            example(result:, name:, time:)
          end

          def self.result = Result.example
          def self.fixture_name = FixtureName.example
          def self.time = Time.example
        end
      end
    end
  end
end
