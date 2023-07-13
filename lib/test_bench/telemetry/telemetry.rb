module TestBench
  class Telemetry
    GetError = Class.new(RuntimeError)

    def sinks
      @sinks ||= []
    end
    attr_writer :sinks

    def record(event)
      if event.is_a?(Event)
        event.metadata ||= Event::Metadata.new

        event_data = Event::Export.(event)
      else
        event_data = event
      end

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

    def get_sink(sink_class)
      sink, *other_sinks = get_sinks(sink_class)

      if other_sinks.any?
        raise GetError, "Multiple sinks match: #{sink_class.inspect}"
      end

      sink
    end

    def get_sinks(sink_class)
      sinks.select do |sink|
        sink.instance_of?(sink_class)
      end
    end
  end
end
