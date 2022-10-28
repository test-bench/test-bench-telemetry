require_relative '../automated_init'

context "Event Serialization" do
  control_event = Controls::Event.example
  control_data = Controls::Event::Data.example

  context "Dump" do
    data = control_event.dump

    comment data.inspect
    detail "Serialized: #{control_data.inspect}"

    test do
      assert(data == control_data)
    end
  end

  context "Load" do
    event_namespace = Controls::Event
    event = Telemetry::Event.load(control_data, event_namespace)

    comment event.inspect
    detail "Original Event: #{control_event.inspect}"

    test do
      assert(event == control_event)
    end
  end
end
