module TestBench
  class Telemetry
    module Controls
      module Events
        module FixtureStarted
          def self.example(name: nil, time: nil)
            name ||= self.fixture_name
            time ||= self.time

            TestBench::Telemetry::Event::FixtureStarted.new(name, time)
          end

          def self.random
            name = FixtureName.random
            time = Time.random

            example(name:, time:)
          end

          def self.fixture_name = FixtureName.example
          def self.time = Time.example
        end
      end
    end
  end
end
