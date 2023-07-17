require_relative '../../automated_init'

context "Projection Sink" do
  context "Apply Event Data" do
    context "Event Class is Registered" do
      projection = Controls::Projection.example

      event_data = Controls::Event.event_data

      imported_event = projection.apply(event_data)

      test "Event is imported" do
        assert(imported_event.instance_of?(Controls::Event::SomeEvent))
      end

      test "Event is applied" do
        assert(projection.applied?(imported_event))
      end
    end

    context "Event Class Isn't Registered" do
      projection = Controls::Projection.example

      control_event_data = Controls::Event::Other.event_data

      event_data = projection.apply(control_event_data)

      test "Event data is applied" do
        assert(projection.applied_event_data?(control_event_data))
      end

      test "Returns the event data" do
        assert(event_data == control_event_data)
      end
    end
  end
end
