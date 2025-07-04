require_relative '../automated_init'

context "Substitute" do
  context "One Event Predicate" do
    substitute = Telemetry::Substitute.build

    event_1 = Controls::Event.example
    event_2 = Controls::Event.random
    event_3 = Controls::Event.other_example

    substitute.record(event_1)
    substitute.record(event_2)
    substitute.record(event_3)

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
