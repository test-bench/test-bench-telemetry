module TestBench
  class Telemetry
    module Controls
      module Events
        module ErrorRaised
          def self.example(error_text: nil, time: nil)
            error_text ||= self.error_text
            time ||= self.time

            TestBench::Telemetry::Event::ErrorRaised.new(error_text, time)
          end

          def self.random
            error_text = Error::Text.random
            time = Time.random

            example(error_text:, time:)
          end

          def self.error_text = Error::Text.example
          def self.time = Time.example
        end
      end
    end
  end
end
