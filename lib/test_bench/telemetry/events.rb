module TestBench
  class Telemetry
    module Events
      def self.load(data)
        event_type, *values = Serialization.load(data)

        cls = const_get(event_type, false)

        cls.new(*values)
      end

      module Event
        def self.define(*attribute_names)
          cls = Struct.new(*attribute_names) do
            include Event
          end
        end

        def self.included(cls)
          cls.class_exec do
            extend EventType
          end
        end

        def dump
          Serialization.dump(event_type, *values)
        end

        def event_type
          self.class.event_type
        end

        module EventType
          def event_type
            @event_type ||=
              begin
                *, constant_name = self.name.split('::')
                constant_name.to_sym
              end
          end
        end
      end

      Asserted = Event.define(:result, :path, :line_number, :time)

      TestStarted = Event.define(:title, :time)
      TestFinished = Event.define(:title, :result, :time)
      TestSkipped = Event.define(:title, :time)

      ContextEntered = Event.define(:title, :time)
      ContextExited = Event.define(:title, :result, :time)
      ContextSkipped = Event.define(:title, :time)

      Commented = Event.define(:title, :time)

      DetailIncreased = Event.define(:level, :time)
      DetailDecreased = Event.define(:level, :time)

      RunStarted = Event.define(:random_seed, :time)
      RunFinished = Event.define(:random_seed, :result, :time)
      RunAborted = Event.define(:random_seed, :time)

      FileEntered = Event.define(:path, :time)
      FileExited = Event.define(:path, :result, :time)
    end
  end
end
