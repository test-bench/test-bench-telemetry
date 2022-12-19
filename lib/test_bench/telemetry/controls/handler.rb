module TestBench
  class Telemetry
    module Controls
      module Handler
        def self.example
          Example.new
        end

        class Example
          include Telemetry::Sink::Handler

          attr_accessor :handled_event

          handle Event::SomeEvent do |some_event|
            self.handled_event = some_event
          end

          def handled?(event=nil)
            return false if handled_event.nil?

            return true if event.nil?

            event == handled_event
          end
        end

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
