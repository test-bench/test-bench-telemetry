module TestBench
  class Telemetry
    module Controls
      module Handler
        def self.example(&block)
          if block.nil?
            cls = Example
          else
            cls = example_class(&block)
          end

          cls.new
        end

        def self.example_class(&block)
          Class.new do
            include TestBench::Telemetry::Sink::Handler

            if not block.nil?
              class_exec(&block)
            end
          end
        end

        module Event
          def self.example(data=nil)
            data ||= self.data

            Controls::Event.example(data)
          end

          def self.data = 'some-data'

          def self.other_example
            Controls::Event::OtherExample.new
          end

          Example = Controls::Event::Example
          OtherExample = Controls::Event::OtherExample
        end

        module Method
          def self.example(event_type=nil)
            event_type ||= Event::Example.event_type

            event_type_method_cased = TestBench::Telemetry::Event::Type.method_cased(event_type)

            :"handle_#{event_type_method_cased}"
          end

          def self.other_example
            event_type = Event::OtherExample.event_type

            example(event_type)
          end
        end

        Example = example_class do
          attr_accessor :data

          handle Event::Example do |data|
            self.data = data
          end

          def handled?(data=nil)
            if data.nil?
              !self.data.nil?
            else
              data == self.data
            end
          end
        end
      end
    end
  end
end
