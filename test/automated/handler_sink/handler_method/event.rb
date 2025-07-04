require_relative '../../automated_init'

context "Handler Sink" do
  context "Handler Method" do
    context "Event" do
      control_handler_method = Controls::Handler::Method.example

      handler_class = Class.new do
        include Telemetry::Sink::Handler

        define_method(control_handler_method) do
        end
      end

      context "Handler Implements Event Handler for Event" do
        event = Controls::Event.example

        handler = handler_class.new

        handler_method = handler.handler_method(event)

        comment handler_method.inspect
        detail "Method: #{control_handler_method.inspect}"

        test do
          assert(handler_method == control_handler_method)
        end
      end

      context "Handler Doesn't Implement Event Handler for Event" do
        event = Controls::Event.other_example

        handler = handler_class.new

        handler_method = handler.handler_method(event)

        comment handler_method.inspect

        test "No Method" do
          assert(handler_method.nil?)
        end
      end
    end
  end
end
