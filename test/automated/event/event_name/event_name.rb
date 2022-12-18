require_relative '../../automated_init'

context "Event" do
  context "Event Name" do
    control_event_name = :some_event

    context "Class" do
      event_class = Controls::Event::SomeEvent

      event_name = event_class.event_name

      comment event_name.inspect
      detail "Control: #{control_event_name.inspect}"

      test do
        assert(event_name == control_event_name)
      end
    end

    context "Insntance" do
      event = Controls::Event.example

      event_name = event.event_name

      comment event_name.inspect
      detail "Control: #{control_event_name.inspect}"

      test do
        assert(event_name == control_event_name)
      end
    end
  end
end
