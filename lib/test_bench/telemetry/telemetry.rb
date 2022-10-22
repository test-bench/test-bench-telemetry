module TestBench
  class Telemetry
    RegistrationError = Class.new(RuntimeError)

    def sinks
      @sinks ||= []
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
  end
end
