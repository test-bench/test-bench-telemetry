require_relative '../../automated_init'

context "Projection Sink" do
  context "Apply Event" do
    context "Projection Implements Apply Method for Event" do
      projection = Controls::Projection.example

      event = Controls::Event.example

      applied_event = projection.apply(event)

      test "Event is applied" do
        assert(projection.applied?(event))
      end

      test "Returns the applied event" do
        assert(applied_event)
      end
    end

    context "Projection Doesn't Implement Apply Method for Event" do
      context "Projection Has an Event Data Projection" do
        projection = Controls::Projection.example

        event = Controls::Event.other_example

        event_data = projection.apply(event)

        test "Applies the event's data" do
          assert(projection.applied_event_data?(event_data))
        end

        context "Exports event data" do
          control_event_data = Telemetry::Event::Export.(event)

          test do
            assert(event_data == control_event_data)
          end
        end
      end

      context "Projection Doesn't Have an Apply Event Data Method" do
        projection = Controls::Projection::NoApplyMethod.example

        event = Controls::Event.example

        test "Isn't an error" do
          refute_raises(NoMethodError) do
            projection.apply(event)
          end
        end
      end
    end
  end
end
