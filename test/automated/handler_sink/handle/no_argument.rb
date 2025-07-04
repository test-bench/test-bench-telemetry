require_relative '../../automated_init'

context "Handler Sink" do
  context "Handle Event" do
    context "Handler Method Doesn't Accept An Argument" do
      handler = Controls::Handler::NoArgument.example

      event = Controls::Event.example

      handler.handle(event)

      test "Event is handled" do
        assert(handler.handled?)
      end
    end
  end
end
