module TestBench
  class Telemetry
    module Event
      module Events
        Asserted = Event.define(:result, :path, :line_number)

        ErrorRaised = Event.define(:error_text)

        TestStarted = Event.define(:title)
        TestFinished = Event.define(:result, :title)
        TestSkipped = Event.define(:title)

        ContextEntered = Event.define(:title)
        ContextExited = Event.define(:result, :title)
        ContextSkipped = Event.define(:title)
      end
      include Events
    end
  end
end
