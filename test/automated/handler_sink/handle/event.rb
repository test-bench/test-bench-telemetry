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
        assert(handled_event)
      end
    end

    context "Handler Doesn't Implement Event Handler for Event" do
      handler = Controls::Handler.example

      event = Controls::Event.other_example

      handled_event = handler.handle(event)

      test "Event isn't handled" do
        refute(handler.handled?)
      end

      test "Returns nothing" do
        assert(handled_event.nil?)
      end
    end
  end
end
