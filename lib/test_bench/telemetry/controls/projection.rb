module TestBench
  class Telemetry
    module Controls
      module Projection
        def self.example(receiver=nil)
          receiver ||= Receiver.example

          Example.new(receiver)
        end

        class Example
          include Telemetry::Sink::Projection

          receiver_name :some_receiver

          apply Event::SomeEvent do |some_event|
            receiver.event(some_event)
          end

          def applied?(event=nil)
            receiver.event?(event)
          end
        end

        module ApplyMethod
          def self.example(event_type=nil)
            event_type ||= Event::SomeEvent.event_type

            event_name = TestBench::Telemetry::Event::EventName.get(event_type)

            :"apply_#{event_name}"
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
