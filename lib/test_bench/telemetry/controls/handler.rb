module TestBench
  class Telemetry
    module Controls
      module Handler
        module Method
          def self.example(event_type=nil)
            event_type ||= Event::SomeEvent.event_type

            event_name = TestBench::Telemetry::Event::EventName.get(event_type)

            :"handle_#{event_name}"
          end

          def self.other_example
            event_type = Event::SomeOtherEvent.event_type

            example(event_type)
          end
        end
      end
    end
  end
end
