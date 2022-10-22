require_relative '../../automated_init'

context "Handler Sink" do
  context "Handle Event" do
    context "Handler Implements Event Handler for Event" do
      handler = Controls::Handler.example

      event = Controls::Event.example

      handled_event = handler.handle(event)

      test "Event is handled" do
        assert(handler.handled?(event))
      end

      test "Returns the handled event" do
        assert(handled_event == event)
      end
    end

    context "Handler Doesn't Implement Event Handler for Event" do
      context "Handler Has an Event Data Handler" do
        handler = Controls::Handler.example

        event = Controls::Event.other_example

        event_data = handler.handle(event)

        test "Handles the event's data" do
          assert(handler.handled_event_data?(event_data))
        end

        context "Exports event data" do
          control_event_data = Telemetry::Event::Export.(event)

          test do
            assert(event_data == control_event_data)
          end
        end
      end

      context "Handler Doesn't Have an Event Data Handler" do
        handler = Controls::Handler::NoHandler.example

        event = Controls::Event.example

        test "Isn't an error" do
          refute_raises(NoMethodError) do
            handler.handle(event)
          end
        end
      end
    end
  end
end
