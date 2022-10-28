module TestBench
  class Telemetry
    module Controls
      module Events
        module FileExited
          def self.example(result: nil, path: nil, executor: nil, time: nil)
            result ||= self.result
            path ||= self.path
            executor ||= self.executor
            time ||= self.time

            TestBench::Telemetry::Event::FileExited.new(result, path, executor, time)
          end

          def self.random
            result = Result.random
            path = Path.random
            executor = Random.integer % self.executor
            time = Time.random

            example(result:, path:, executor:, time:)
          end

          def self.result = Result.example
          def self.path = Path.example
          def self.executor = 1
          def self.time = Time.example
        end
      end
    end
  end
end
