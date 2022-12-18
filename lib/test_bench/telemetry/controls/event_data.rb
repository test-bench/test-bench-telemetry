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
          Random.example
        end

        def self.type
          Type.example
        end

        module Random
          def self.example(type: nil)
            type ||= Type.random

            EventData.example(type:)
          end
        end

        module Type
          def self.example
            :SomeEvent
          end

          def self.other_example
            :SomeOtherEvent
          end

          def self.random
            :"#{example}#{Controls::Random.string}"
          end
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
