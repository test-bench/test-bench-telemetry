module TestBench
  class Telemetry
    module Controls
      module EventData
        def self.example(type: nil)
          type ||= self.type

          event_data = Telemetry::EventData.new
          event_data.type = type
          event_data
        end

        def self.random
          type = Type.random

          example(type:)
        end

        def self.type = Type.example

        module Type
          def self.example = :SomeEvent
          def self.other_example = :SomeOtherEvent
          def self.random = :"#{example}#{Random.string}"
        end

        module Text
          def self.example(type: nil)
            type ||= EventData.type

            "#{type}\r\n"
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
