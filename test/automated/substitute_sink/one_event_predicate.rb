require_relative '../automated_init'

context "Substitute Sink" do
  context "One Event Predicate" do
    substitute = Telemetry::Substitute::Sink.new

    event_1 = Controls::Event.example
    event_2 = Controls::Event.random
    event_3 = Controls::Event.other_example

    [event_1, event_2, event_3].each do |event|
      event_data = Telemetry::Event::Export.(event)

      substitute.receive(event_data)
    end

    context "One Event Matches" do
      attributes = event_1.to_h

      one_event = substitute.one_event?(Controls::Event::SomeEvent, **attributes)

      comment one_event.inspect

      test do
        assert(one_event)
      end
    end

    context "Multiple Events Match" do
      test "Is an error" do
        assert_raises(Telemetry::Substitute::Sink::MatchError) do
          substitute.one_event?(Controls::Event::SomeEvent)
        end
      end
    end

    context "No Events Match" do
      compare_event = Controls::Event.random
      attributes = compare_event.to_h

      one_event = substitute.one_event?(Controls::Event::SomeEvent, **attributes)

      comment one_event.inspect

      test do
        refute(one_event)
      end
    end
  end
end
