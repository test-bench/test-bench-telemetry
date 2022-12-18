module TestBench
  class Telemetry
    module Event
      def self.define(&blk)
        Struct.new(:metadata) do
          include Event

          if not blk.nil?
            instance_exec(&blk)
          end
        end
      end

      def self.included(cls)
        cls.class_exec do
          extend EventType
          extend EventName
        end
      end

      def event_type
        self.class.event_type
      end

      def event_name
        self.class.event_name
      end

      module EventType
        def event_type
          *, inner_namespace = self.name.split('::')

          inner_namespace.to_sym
        end
      end

      module EventName
        def event_name
          EventName.get(event_type)
        end

        def self.get(event_type)
          pascal_cased = event_type.to_s

          underscore_cased = pascal_cased.gsub(%r{(?:\A|[a-z])[A-Z]+}) do |match_text|
            if ('a'..'z').include?(match_text[0])
              match_text.insert(1, '_')
            end
            match_text.downcase!
            match_text
          end

          underscore_cased.to_sym
        end
      end

      Metadata = Struct.new(:process_id, :time)
    end
  end
end
