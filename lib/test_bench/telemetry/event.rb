module TestBench
  class Telemetry
    module Event
      def self.define
        Struct.new(:metadata) do
          include Event
        end
      end

      def self.included(cls)
        cls.class_exec do
          extend EventType
        end
      end

      def event_type
        self.class.event_type
      end

      module EventType
        def event_type
          *, inner_namespace = self.name.split('::')

          inner_namespace.to_sym
        end
      end

      Metadata = Struct.new(:process_id, :time)
    end
  end
end
