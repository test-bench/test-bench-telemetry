module TestBench
  class Telemetry
    module Controls
      module Sink
        def self.example
          Example.new
        end

        class Example
          include Telemetry::Sink

          attr_accessor :received_event_data

          def receive(event_data)
            self.received_event_data = event_data
          end

          def received?(event_data)
            self.received_event_data == event_data
          end
        end
      end
    end
  end
end
