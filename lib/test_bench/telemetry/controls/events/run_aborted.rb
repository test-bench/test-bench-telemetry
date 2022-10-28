module TestBench
  class Telemetry
    module Controls
      module Events
        module RunAborted
          def self.example(random_seed: nil, executors: nil, time: nil)
            random_seed ||= self.random_seed
            executors ||= self.executors
            time ||= self.time

            TestBench::Telemetry::Event::RunAborted.new(random_seed, executors, time)
          end

          def self.random
            random_seed = Random.integer
            executors = Random.integer % self.executors
            time = Time.random

            example(random_seed:, executors:, time:)
          end

          def self.random_seed = 1
          def self.executors = 11
          def self.time = Time.example
        end
      end
    end
  end
end
