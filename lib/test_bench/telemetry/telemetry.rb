module TestBench
  class Telemetry
    include Event::Events

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

    Event.each_event_type do |event_type|
      event_class = Event.const_get(event_type)

      event_type_method_cased = Event::Type.method_cased(event_type)

      module_eval(<<~RUBY, __FILE__, __LINE__)
      def record_#{event_type_method_cased}(*values)
        event = #{event_class}.new(*values)

        record(event)
      end
      RUBY
    end

    def current_time(now)
      now || ::Time.now
    end
  end
end
