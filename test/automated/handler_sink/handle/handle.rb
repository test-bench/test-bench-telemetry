require_relative '../../automated_init'

context "Handler Sink" do
  context "Handle Event" do
    context "Handler Implements Event Handler for Event" do
      handler = Controls::Handler.example

      data = Controls::Random.string
      event = Controls::Handler::Event.example(data)

      handled = handler.(event)

      test "Event is handled" do
        assert(handler.handled?(data))
      end

      test "Returns true" do
        assert(handled)
      end
    end

    context "Handler Doesn't Implement Event Handler for Event" do
      handler = Controls::Handler.example

      event = Controls::Handler::Event.other_example

      handled = handler.(event)

      test "Event isn't handled" do
        refute(handler.handled?)
      end

      test "Returns false" do
        refute(handled)
      end
    end
  end
end
