module TestBench
  class Telemetry
    module Controls
      module EventData
        def self.example(type: nil, process_id: nil, time: nil, data: nil)
          type ||= self.type
          process_id ||= self.process_id
          time ||= self.time
          data ||= self.data

          event_data = Telemetry::EventData.new
          event_data.type = type
          event_data.process_id = process_id
          event_data.time = time
          event_data.data = data
          event_data
        end

        def self.random
          type = Type.random
          process_id = ProcessID.random
          time = Time.random
          data = Data.random

          example(type:, process_id:, time:, data:)
        end

        def self.type = Type.example
        def self.process_id = ProcessID.example
        def self.time = Time.example
        def self.data = Data.example

        module Type
          def self.example = :SomeEvent
          def self.other_example = :SomeOtherEvent
          def self.random = :"#{example}#{Random.string}"
        end

        module Data
          def self.example
            [
              nil,
              true,
              false
            ]
          end

          def self.random
            [
              nil,
              Random.boolean,
              Random.boolean
            ]
          end
        end

        module Text
          def self.example(type: nil, process_id: nil, time: nil)
            type ||= EventData.type
            process_id ||= EventData.process_id
            time ||= EventData.time

            time_iso8601 = Time::ISO8601.example(time)

            "#{type}\t#{process_id}\t#{time_iso8601}\t\ttrue\tfalse\r\n"
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
