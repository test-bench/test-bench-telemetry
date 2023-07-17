module TestBench
  class Telemetry
    module Sink
      module Projection
        def self.included(cls)
          cls.class_exec do
            extend ReceiverNameMacro

            extend ApplyMethod
            extend ApplyMacro
          end
        end

        attr_accessor :receiver

        def initialize(receiver)
          @receiver = receiver
        end

        def apply?(...)
          apply_method = apply_method(...)

          not apply_method.nil?
        end

        def apply_method(event_or_event_data)
          apply_method = self.class.apply_method(event_or_event_data)

          if respond_to?(apply_method)
            apply_method
          else
            nil
          end
        end

        module ReceiverNameMacro
          def receiver_name_macro(receiver_name)
            define_method(receiver_name) do
              receiver
            end
          end
          alias :receiver_name :receiver_name_macro
        end

        module ApplyMacro
          def apply_macro(event_class, &block)
            event_registry.register(event_class)

            event_type = event_class.event_type

            apply_method = ApplyMethod.get(event_type)

            define_method(apply_method, &block)
          end
          alias :apply :apply_macro

          def event_registry
            @event_registry ||= Handler::EventRegistry.new
          end
        end

        module ApplyMethod
          def apply_method(event_or_event_data)
            if event_or_event_data.is_a?(Event)
              event = event_or_event_data
              event_type = event.event_type
            else
              event_data = event_or_event_data
              event_type = event_data.type
            end

            ApplyMethod.get(event_type)
          end

          def self.get(event_type)
            event_name = Event::EventName.get(event_type)

            :"apply_#{event_name}"
          end
        end
      end
    end
  end
end
