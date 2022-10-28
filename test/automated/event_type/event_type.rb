require_relative '../automated_init'

context "Event Type" do
  event = Controls::Event.example

  control_event_type = Controls::Event::Type.example
  event_type = event.event_type

  comment event_type.inspect
  detail "Control: #{control_event_type.inspect}"

  test do
    assert(event_type == control_event_type)
  end
end
