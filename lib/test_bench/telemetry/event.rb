module TestBench
  class Telemetry
    module Event
      def self.define(*attribute_names)
        Struct.new(*attribute_names, :time) do
          include Event
        end
      end

      def self.included(cls)
        cls.class_exec do
          extend EventType
        end
      end

      def self.each_event_type(&block)
        Events.constants(false).each(&block)
      end

      def event_type
        self.class.event_type
      end

      def dump
        Serialization.dump(self)
      end

      def self.load(data, event_namespace=nil)
        event_namespace ||= Events

        Serialization.load(data, event_namespace)
      end

      module EventType
        def event_type
          @event_type ||= Type.get(name)
        end
      end
    end
  end
end
