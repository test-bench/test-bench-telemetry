require_relative '../automated_init'

context "Event" do
  context "Event Type" do
    control_event_type = :SomeEvent

    context "Class" do
      event_class = Controls::Event::SomeEvent

      event_type = event_class.event_type

      comment event_type.inspect
      detail "Control: #{control_event_type.inspect}"

      test "Inner-most namespace of event class's name" do
        assert(event_type == control_event_type)
      end
    end

    context "Instance" do
      event = Controls::Event.example

      event_type = event.event_type

      comment event_type.inspect
      detail "Control: #{control_event_type.inspect}"

      test "Inner-most namespace of event class's name" do
        assert(event_type == control_event_type)
      end
    end
  end
end
