module TestBench
  class Telemetry
    RegistrationError = Class.new(RuntimeError)

    def sinks
      @sinks ||= []
    end

    def record(event, now=nil)
      event.time ||= current_time(now)

      sinks.each do |sink|
        sink.(event)
      end

      event
    end

    def register(sink)
      if registered?(sink)
        raise RegistrationError, "Already registered #{sink.inspect}"
      end

      sinks << sink
    end

    def registered?(sink)
      sinks.include?(sink)
    end

    def current_time(now)
      now || ::Time.now
    end
  end
end
