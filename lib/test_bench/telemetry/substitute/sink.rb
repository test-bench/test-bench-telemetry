module TestBench
  class Telemetry
    module Substitute
      class Sink
        include Telemetry::Sink

        def received_events
          @received_events ||= []
        end

        def receive(event_data)
          received_events << event_data
        end

        def received?(event_data)
          received_events.include?(event_data)
        end

        def events(event_class, **attributes)
          event_type = event_class.event_type

          events = []

          received_events.each do |event_data|
            event_types_correspond = event_data.type == event_type

            if event_types_correspond
              event = Event::Import.(event_data, event_class)

              attributes_correspond = attributes.all? do |attribute, compare_value|
                value = event.public_send(attribute)

                value == compare_value
              end

              if attributes_correspond
                events << event
              end
            end
          end

          events
        end
      end
    end
  end
end
