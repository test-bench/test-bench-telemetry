module TestBench
  class Telemetry
    module Controls
      module Event
        def self.example(metadata: nil, process_id: nil, time: nil, event_class: nil)
          metadata ||= Metadata.example(process_id:, time:)
          event_class ||= SomeEvent

          event = event_class.new
          event.metadata = metadata
          event
        end

        def self.process_id = Controls::EventData.process_id
        def self.time = Controls::EventData.time

        SomeEvent = TestBench::Telemetry::Event.define

        module Metadata
          def self.example(process_id: nil, time: nil)
            if process_id == :none
              process_id = nil
            else
              process_id ||= self.process_id
            end

            if time == :none
              time = nil
            else
              time ||= self.time
            end

            metadata = Telemetry::Event::Metadata.new
            metadata.process_id = process_id
            metadata.time = time
            metadata
          end

          def self.other_example = Other.example
          def self.random = Random.example

          def self.process_id = Controls::ProcessID.example
          def self.time = Controls::Time.example

          module Other
            def self.example
              Metadata.example(process_id:, time:)
            end

            def self.process_id = Controls::ProcessID.other_example
            def self.time = Controls::Time.other_example
          end

          module Random
            def self.example
              process_id = Controls::ProcessID.random
              time = Controls::Time.random

              Metadata.example(process_id:, time:)
            end
          end
        end
      end
    end
  end
end
