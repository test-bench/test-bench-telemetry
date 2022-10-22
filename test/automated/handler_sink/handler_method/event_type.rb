require_relative '../../automated_init'

context "Handler Sink" do
  context "Handler Method" do
    context "Event Type" do
      control_handler_method = Controls::Handler::Method.example

      handler = Controls::Handler.example do
        define_method(control_handler_method) do
        end
      end

      context "Handler Implements Event Handler for Event Type" do
        event_type = Controls::Handler::Event::Example.event_type

        handler_method = handler.handler_method(event_type)

        comment handler_method.inspect
        detail "Method: #{control_handler_method.inspect}"

        test do
          assert(handler_method == control_handler_method)
        end
      end

      context "Handler Doesn't Implement Event Handler for Event Type" do
        event_type = Controls::Handler::Event::OtherExample.event_type

        handler_method = handler.handler_method(event_type)

        comment handler_method.inspect

        test "No Method" do
          assert(handler_method.nil?)
        end
      end
    end
  end
end
