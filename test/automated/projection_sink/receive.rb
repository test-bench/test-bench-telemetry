require_relative '../automated_init'

context "Projection Sink" do
  context "Receive" do
    projection = Controls::Projection.example

    event_data = Controls::Event.event_data
    control_event = Controls::Event.example

    projection.receive(event_data)

    test "Event is applied" do
      assert(projection.applied?(control_event))
    end
  end
end
