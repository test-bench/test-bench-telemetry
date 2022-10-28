module TestBench
  class Telemetry
    module Controls
      module Events
        module RunFinished
          def self.example(result: nil, random_seed: nil, executors: nil, time: nil)
            result ||= self.result
            random_seed ||= self.random_seed
            executors ||= self.executors
            time ||= self.time

            TestBench::Telemetry::Event::RunFinished.new(result, random_seed, executors, time)
          end

          def self.random
            result = Result.random
            random_seed = Random.integer
            executors = Random.integer % self.executors
            time = Time.random

            example(result:, random_seed:, executors:, time:)
          end

          def self.result = Result.example
          def self.random_seed = RunStarted.random_seed
          def self.executors = RunStarted.executors
          def self.time = Time.example
        end
      end
    end
  end
end
