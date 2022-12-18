require_relative '../../automated_init'

context "Handler Sink" do
  context "Handle Event Data" do
    context "Event Class is Registered" do
      handler = Controls::Handler.example

      event_data = Controls::Event::EventData.example

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

      event_data = Controls::EventData.random

      imported_event = handler.handle(event_data)

      test "Doesn't import an event" do
        assert(imported_event.nil?)
      end
    end
  end
end
