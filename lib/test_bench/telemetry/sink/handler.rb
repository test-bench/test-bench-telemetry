module TestBench
  class Telemetry
    module Sink
      module Handler
        def self.included(cls)
          cls.class_exec do
            include Sink

            extend HandlerMethod
          end
        end

        def handler_method(event_or_event_data)
          handler_method = self.class.handler_method(event_or_event_data)

          if respond_to?(handler_method)
            handler_method
          else
            nil
          end
        end

        module HandlerMethod
          def handler_method(event_or_event_data)
            if event_or_event_data.is_a?(Event)
              event = event_or_event_data
              event_type = event.event_type
            else
              event_data = event_or_event_data
              event_type = event_data.type
            end

            HandlerMethod.get(event_type)
          end

          def self.get(event_type)
            event_name = Event::EventName.get(event_type)

            :"handle_#{event_name}"
          end
        end
      end
    end
  end
end
