require_relative '../automated_init'

context "Handler Sink" do
  context "Receive" do
    handler = Controls::Handler.example

    event_data = Controls::Event.event_data
    control_event = Controls::Event.example

    handler.receive(event_data)

    test "Event is handled" do
      assert(handler.handled?(control_event))
    end
  end
end
