module TestBench
  class Telemetry
    module Substitute
      class Sink
        include Telemetry::Sink

        def received_events
          @received_events ||= []
        end

        def receive(event_data)
          received_events << event_data
        end

        def received?(event_data)
          received_events.include?(event_data)
        end
      end
    end
  end
end
