module TestBench
  class Telemetry
    module Controls
      module Events
        module Commented
          def self.example(comment: nil, time: nil)
            comment ||= self.comment
            time ||= self.time

            TestBench::Telemetry::Event::Commented.new(comment, time)
          end

          def self.random
            comment = Comment.random
            time = Time.random

            example(comment:, time:)
          end

          def self.comment = Comment.example
          def self.time = Time.example
        end
      end
    end
  end
end
