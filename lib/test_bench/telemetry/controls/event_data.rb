module TestBench
  class Telemetry
    module Controls
      module EventData
        def self.example(type: nil, process_id: nil, time: nil)
          type ||= self.type
          process_id ||= self.process_id
          time ||= self.time

          event_data = Telemetry::EventData.new
          event_data.type = type
          event_data.process_id = process_id
          event_data.time = time
          event_data
        end

        def self.random
          type = Type.random
          process_id = ProcessID.random
          time = Time.random

          example(type:, process_id:, time:)
        end

        def self.type = Type.example
        def self.process_id = ProcessID.example
        def self.time = Time.example

        module Type
          def self.example = :SomeEvent
          def self.other_example = :SomeOtherEvent
          def self.random = :"#{example}#{Random.string}"
        end

        module Text
          def self.example(type: nil, process_id: nil, time: nil)
            type ||= EventData.type
            process_id ||= EventData.process_id
            time ||= EventData.time

            time_iso8601 = Time::ISO8601.example(time)

            "#{type}\t#{process_id}\t#{time_iso8601}\r\n"
          end

          module Malformed
            module Empty
              def self.example = ''
            end

            module IncorrectEventType
              def self.example
                Text.example(type:)
              end

              def self.type = :not_pascal_cased
            end

            module IncorrectNewlines
              def self.example
                text = Text.example
                text.chomp!("\r\n")
                text << "\n"
                text
              end
            end
          end
        end
      end
    end
  end
end
