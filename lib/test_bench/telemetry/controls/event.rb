module TestBench
  class Telemetry
    module Controls
      module Event
        def self.example(event_class: nil, metadata: nil, process_id: nil, time: nil)
          metadata ||= Metadata.example(process_id:, time:)
          event_class ||= SomeEvent

          event = event_class.new
          event.metadata = metadata
          event
        end

        def self.other_example
          Other.example
        end

        def self.random
          Random.example(event_class:)
        end

        def self.event_class
          SomeEvent
        end

        def self.process_id
          Controls::EventData.process_id
        end

        def self.time
          Controls::EventData.time
        end

        SomeEvent = TestBench::Telemetry::Event.define
        SomeOtherEvent = TestBench::Telemetry::Event.define

        module Other
          def self.example(metadata: nil, process_id: nil, time: nil)
            metadata ||= Metadata::Other.example(process_id:, time:)

            Event.example(event_class:, metadata:)
          end

          def self.event_class
            SomeOtherEvent
          end
        end

        module Random
          def self.example(event_class: nil, metadata: nil, process_id: nil, time: nil)
            event_class ||= self.event_class
            metadata ||= Metadata::Random.example(process_id:, time:)

            Event.example(event_class:, metadata:)
          end

          def self.event_class
            if Controls::Random.boolean
              SomeEvent
            else
              SomeOtherEvent
            end
          end
        end
      end
    end
  end
end
