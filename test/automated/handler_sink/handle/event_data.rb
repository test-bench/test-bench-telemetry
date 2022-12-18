require_relative '../../automated_init'

context "Handler Sink" do
  context "Handle Event Data" do
    context "Event Class is Registered" do
      handler = Controls::Handler.example

      event_data = Controls::Event.event_data

      imported_event = handler.handle(event_data)

      test "Event is imported" do
        assert(imported_event.instance_of?(Controls::Event::SomeEvent))
      end

      test "Event is handled" do
        assert(handler.handled?(imported_event))
      end
    end

    context "Event Class Isn't Registered" do
      handler = Controls::Handler.example

      control_event_data = Controls::Event::Other.event_data

      event_data = handler.handle(control_event_data)

      test "Event data is handled" do
        assert(handler.handled_event_data?(control_event_data))
      end

      test "Returns the event data" do
        assert(event_data == control_event_data)
      end
    end
  end
end
