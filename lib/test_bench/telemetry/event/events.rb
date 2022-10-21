module TestBench
  class Telemetry
    module Event
      module Events
        Asserted = Event.define(:result, :path, :line_number)
      end
      include Events
    end
  end
end
