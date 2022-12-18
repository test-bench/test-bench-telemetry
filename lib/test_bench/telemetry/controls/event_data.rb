module TestBench
  class Telemetry
    module Controls
      module EventData
        def self.example(type: nil, process_id: nil)
          type ||= self.type
          process_id ||= self.process_id

          event_data = Telemetry::EventData.new
          event_data.type = type
          event_data.process_id = process_id
          event_data
        end

        def self.random
          type = Type.random
          process_id = ProcessID.random

          example(type:, process_id:)
        end

        def self.type = Type.example
        def self.process_id = ProcessID.example

        module Type
          def self.example = :SomeEvent
          def self.other_example = :SomeOtherEvent
          def self.random = :"#{example}#{Random.string}"
        end

        module Text
          def self.example(type: nil, process_id: nil)
            type ||= EventData.type
            process_id ||= EventData.process_id

            "#{type}\t#{process_id}\r\n"
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
