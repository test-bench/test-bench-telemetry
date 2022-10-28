module TestBench
  class Telemetry
    module Controls
      module Event
        def self.example
          event = Example.new
          event.time = time
          event
        end

        def self.time = Time.example

        SomeEvent = TestBench::Telemetry::Event.define
        Example = SomeEvent

        SomeOtherEvent = TestBench::Telemetry::Event.define
        OtherExample = SomeOtherEvent

        module Type
          def self.example = SomeEvent.event_type
          def self.other_example = :SomeOtherEvent
        end
      end
    end
  end
end
