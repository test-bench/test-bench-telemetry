require_relative '../automated_init'

context "Substitute Sink" do
  context "Events" do
    substitute = Telemetry::Substitute::Sink.new

    event_1 = Controls::Event.example
    event_2 = Controls::Event.random
    event_3 = Controls::Event.other_example

    [event_1, event_2, event_3].each do |event|
      event_data = Telemetry::Event::Export.(event)

      substitute.receive(event_data)
    end

    context "Multiple Events Match" do
      events = substitute.events(Controls::Event::SomeEvent)
      control_events = [event_1, event_2]

      comment events.count.inspect
      detail "Matching Events: #{control_events.count}"

      test do
        assert(events == control_events)
      end
    end

    context "One Event Matches" do
      attributes = event_1.to_h

      events = substitute.events(Controls::Event::SomeEvent, **attributes)

      control_events = [event_1]

      comment events.count.inspect
      detail "Matching Events: #{control_events.count}"

      test do
        assert(events == control_events)
      end
    end

    context "No Events Match" do
      compare_event = Controls::Event.random
      attributes = compare_event.to_h

      events = substitute.events(Controls::Event::SomeEvent, **attributes)

      control_events = []

      comment events.count.inspect
      detail "Matching Events: #{control_events.count}"

      test do
        assert(events == control_events)
      end
    end
  end
end
