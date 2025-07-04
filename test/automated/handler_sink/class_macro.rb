require_relative '../automated_init'

context "Handler Sink" do
  context "Class Macro" do
    handler = Controls::Handler.example

    handler_method = Controls::Handler::Method.example

    context! "Implements an event handler" do
      implemented = handler.respond_to?(handler_method)

      test do
        assert(implemented)
      end
    end

    context "Registers event class" do
      registry = handler.class.event_registry

      registered = registry.registered?(Controls::Event::SomeEvent)

      test do
        assert(registered)
      end
    end

    context "Handle an Event" do
      refute(handler.handled?)

      event = Controls::Event.example

      handler.public_send(handler_method, event)

      test do
        assert(handler.handled?(event))
      end
    end
  end
end
