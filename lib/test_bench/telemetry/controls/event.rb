module TestBench
  class Telemetry
    module Controls
      module Event
        def self.example(some_attribute: nil, some_other_attribute: nil, metadata: nil, process_id: nil, time: nil, event_class: nil)
          some_attribute ||= self.some_attribute
          some_other_attribute ||= self.some_other_attribute
          metadata ||= Metadata.example(process_id:, time:)
          event_class ||= SomeEvent

          event = event_class.new
          event.some_attribute = some_attribute
          event.some_other_attribute = some_other_attribute
          event.metadata = metadata
          event
        end

        def self.other_example
          metadata = Metadata.other_example

          Event.example(event_class: SomeOtherEvent, metadata:)
        end

        def self.random
          some_attribute, some_other_attribute = Data.random
          metadata = Metadata.random

          Event.example(some_attribute:, some_other_attribute:, metadata:)
        end

        def self.some_attribute = Data.some_attribute
        def self.some_other_attribute = Data.some_other_attribute
        def self.process_id = Controls::EventData.process_id
        def self.time = Controls::EventData.time

        SomeEvent = TestBench::Telemetry::Event.define(:some_attribute, :some_other_attribute)
        SomeOtherEvent = TestBench::Telemetry::Event.define(:some_attribute, :some_other_attribute)

        module EventData
          def self.example(data: nil, type: nil, process_id: nil, time: nil)
            data ||= self.data

            Controls::EventData.example(type:, process_id:, time:, data:)
          end

          def self.other_example = Other.example
          def self.random = Random.example

          def self.data = Data.example

          module Other
            def self.example
              EventData.example(type:, process_id:, time:)
            end

            def self.type = SomeOtherEvent.event_type
            def self.process_id = Metadata::Other.process_id
            def self.time = Metadata::Other.time
          end

          module Random
            def self.example
              data = Data.random
              process_id = ProcessID.random
              time = Time.random

              EventData.example(data:, process_id:, time:)
            end
          end
        end

        module Data
          def self.example
            [some_attribute, some_other_attribute]
          end

          def self.random
            [
              "#{some_attribute}-#{Random.string}",
              "#{some_other_attribute}-#{Random.string}"
            ]
          end

          def self.some_attribute = 'some-value'
          def self.some_other_attribute = 'some-other-value'
        end

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
