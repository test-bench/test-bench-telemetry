module TestBench
  class Telemetry
    module Controls
      module CaptureSink
        module Record
          def self.example(event: nil, path: nil, detail_level: nil)
            event ||= self.event
            path ||= self.path
            detail_level ||= self.detail_level

            TestBench::Telemetry::Sink::Capture::Record.new(event, path, detail_level)
          end

          def self.event = Event.example
          def self.path = Path.example
          def self.detail_level = DetailLevel.example
        end
      end
    end
  end
end
