module TestBench
  class Telemetry
    module Sink
      module Handler
        def self.included(cls)
          cls.class_exec do
            include Sink

            extend HandlerMethod
            extend HandleMacro
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

        module HandleMacro
          def handle_macro(event_class, &block)
            event_registry.register(event_class)

            event_type = event_class.event_type

            handler_method = HandlerMethod.get(event_type)

            define_method(handler_method, &block)
          end
          alias :handle :handle_macro

          def event_registry
            @event_registry ||= EventRegistry.new
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
