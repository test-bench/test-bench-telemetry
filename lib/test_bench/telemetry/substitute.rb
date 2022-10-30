module TestBench
  class Telemetry
    module Substitute
      def self.build
        Telemetry.build
      end

      class Telemetry < Telemetry
        def capture_sink
          @capture_sink ||= Sink::Capture.new
        end

        def self.build
          instance = new
          instance.register(instance.capture_sink)
          instance
        end

        Event.each_event_type do |event_type|
          event_type_method_cased = Event::Type.method_cased(event_type)

          module_eval(<<~RUBY, __FILE__, __LINE__)
          def #{event_type_method_cased}_records(*arguments, **keyword_arguments, &block)
            block ||= proc { true }

            records(*arguments, **keyword_arguments) do |compare_event_type, *event_values|
              if compare_event_type == #{event_type.inspect}
                block.(*event_values)
              end
            end
          end
          RUBY
        end

        def records(...) = capture_sink.records(...)
      end
    end
  end
end
