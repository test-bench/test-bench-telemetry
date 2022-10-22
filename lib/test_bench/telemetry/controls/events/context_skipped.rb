module TestBench
  class Telemetry
    module Controls
      module Events
        module ContextSkipped
          def self.example(title: nil, time: nil)
            time ||= self.time

            if title == :none
              title = nil
            else
              title ||= self.title
            end

            TestBench::Telemetry::Event::ContextSkipped.new(title, time)
          end

          def self.random
            title = Title::Context.random
            time = Time.random

            example(title:, time:)
          end

          def self.title = Title::Context.example
          def self.time = Time.example
        end
      end
    end
  end
end
