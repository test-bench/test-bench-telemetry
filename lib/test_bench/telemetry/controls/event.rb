module TestBench
  class Telemetry
    module Controls
      module Event
        def self.example
          event = Example.new
          event.time = time
          event
        end

        def self.time = Time.example

        SomeEvent = TestBench::Telemetry::Event.define(
          :some_optional
        )
        Example = SomeEvent

        SomeOtherEvent = TestBench::Telemetry::Event.define
        OtherExample = SomeOtherEvent

        module Type
          def self.example = SomeEvent.event_type
          def self.other_example = SomeOtherEvent.event_type
          def self.random = :"#{example}#{Random.string}"
        end

        module Data
          def self.example(event_type: nil)
            event_type ||= SomeEvent.event_type

            time_iso8601 = Time::ISO8601.example

            %{#{event_type}\t\t#{time_iso8601}\r\n}
          end

          module Malformed
            module Empty
              def self.example = ''
            end

            module NoData
              def self.example = "SomeEvent\r\n"
            end

            module IncorrectEventType
              def self.example
                Data.example(event_type:)
              end

              def self.event_type = :not_pascal_cased
            end

            module IncorrectNewlines
              def self.example
                %{SomeEvent\t\t\n}
              end
            end
          end
        end
      end
    end
  end
end
