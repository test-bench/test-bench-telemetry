module TestBench
  class Telemetry
    module Controls
      module Event
        def self.example(some_string=nil)
          some_string ||= self.some_string

          event = Example.new
          event.some_string = some_string
          event.some_integer = some_integer
          event.some_boolean = some_boolean
          event.some_other_boolean = some_other_boolean
          event.time = time
          event
        end

        def self.some_string = 'some-string'
        def self.some_integer = 11
        def self.some_boolean = true
        def self.some_other_boolean = false
        def self.time = Time.example

        SomeEvent = TestBench::Telemetry::Event.define(
          :some_string,
          :some_integer,
          :some_boolean,
          :some_other_boolean,
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

            %{#{event_type}\t"some-string"\t11\ttrue\tfalse\t\t#{time_iso8601}\r\n}
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
