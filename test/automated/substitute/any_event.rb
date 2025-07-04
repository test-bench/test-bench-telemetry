require_relative '../automated_init'

context "Substitute" do
  context "Any Event Predicate" do
    substitute = Telemetry::Substitute.build

    event_1 = Controls::Event.example
    event_2 = Controls::Event.random
    event_3 = Controls::Event.other_example

    substitute.record(event_1)
    substitute.record(event_2)
    substitute.record(event_3)

    context "Multiple Events Match" do
      any_event = substitute.event?(Controls::Event::SomeEvent)

      comment any_event.inspect

      test do
        assert(any_event)
      end
    end

    context "One Event Matches" do
      attributes = event_1.to_h

      any_event = substitute.event?(Controls::Event::SomeEvent, **attributes)

      comment any_event.inspect

      test do
        assert(any_event)
      end
    end

    context "No Events Match" do
      compare_event = Controls::Event.random
      attributes = compare_event.to_h

      any_event = substitute.event?(Controls::Event::SomeEvent, **attributes)

      comment any_event.inspect

      test do
        refute(any_event)
      end
    end
  end
end
