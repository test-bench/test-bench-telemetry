module TestBench
  class Telemetry
    module Controls
      module Events
        module DetailDecreased
          def self.example(time: nil)
            time ||= self.time

            TestBench::Telemetry::Event::DetailDecreased.new(time)
          end

          def self.random
            time = Time.random

            example(time:)
          end

          def self.time = Time.example
        end
      end
    end
  end
end
