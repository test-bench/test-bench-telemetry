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

    context "Event handler" do
      refute(handler.handled?)

      data = Controls::Random.string
      handler.public_send(handler_method, data)

      test do
        assert(handler.handled?(data))
      end
    end
  end
end
