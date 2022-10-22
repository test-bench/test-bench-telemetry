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

        def handler_method(event_or_event_type)
          handler_method = self.class.handler_method(event_or_event_type)

          if respond_to?(handler_method)
            handler_method
          else
            nil
          end
        end

        module HandlerMethod
          def handler_method(event_or_event_type)
            HandlerMethod.get(event_or_event_type)
          end

          def self.get(event_or_event_type)
            if event_or_event_type.is_a?(Symbol)
              event_type = event_or_event_type
            else
              event = event_or_event_type
              event_type = event.event_type
            end

            event_type_method_cased = Event::Type.method_cased(event_type)

            :"handle_#{event_type_method_cased}"
          end
        end
      end
    end
  end
end
