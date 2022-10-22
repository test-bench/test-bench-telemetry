module TestBench
  class Telemetry
    module Controls
      module Events
        module FileEntered
          def self.example(path: nil, executor: nil, time: nil)
            path ||= self.path
            executor ||= self.executor
            time ||= self.time

            TestBench::Telemetry::Event::FileEntered.new(path, executor, time)
          end

          def self.random
            path = Path.random
            executor = Random.integer % self.executor
            time = Time.random

            example(path:, executor:, time:)
          end

          def self.path = Path.example
          def self.executor = 1
          def self.time = Time.example
        end
      end
    end
  end
end
