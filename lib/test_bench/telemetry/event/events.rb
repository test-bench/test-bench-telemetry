module TestBench
  class Telemetry
    module Event
      module Events
        Asserted = Event.define(:result, :path, :line_number)

        ErrorRaised = Event.define(:error_text)
      end
      include Events
    end
  end
end
