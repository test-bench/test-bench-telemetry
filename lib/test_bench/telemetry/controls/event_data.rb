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
          Random.example
        end

        def self.type
          Type.example
        end

        def self.process_id
          ProcessID.example
        end

        module Random
          def self.example(type: nil, process_id: nil)
            type ||= Type.random
            process_id ||= ProcessID.random

            EventData.example(type:, process_id:)
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
          def self.example(type: nil, process_id: nil)
            type ||= EventData.type
            process_id ||= EventData.process_id

            "#{type}\t#{process_id}\r\n"
          end

          module Malformed
            module Empty
              def self.example
                ''
              end
            end

            module IncorrectEventType
              def self.example
                Text.example(type:)
              end

              def self.type
                :not_pascal_cased
              end
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
