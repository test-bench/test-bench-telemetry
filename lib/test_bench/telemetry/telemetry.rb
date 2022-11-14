module TestBench
  class Telemetry
    def sinks
      @sinks ||= []
    end
    attr_writer :sinks

    def record(event)
      event.metadata ||= Event::Metadata.new

      event_data = Event::Export.(event)

      event_data.process_id ||= process_id
      event_data.time ||= current_time

      sinks.each do |sink|
        sink.receive(event_data)
      end

      event_data
    end

    def current_time
      self.class.current_time
    end

    def process_id
      self.class.process_id
    end

    def self.current_time
      ::Time.now
    end

    def self.process_id
      ::Process.pid
    end
  end
end
