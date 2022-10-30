require_relative '../../automated_init'

context "Substitute" do
  context "Record Event" do
    context "Event Data" do
      substitute = Telemetry::Substitute.build

      control_event_data = Controls::EventData.example
      detail "Event Data: #{control_event_data.inspect}"

      event_data = substitute.record(control_event_data)

      context "Sink" do
        sink = substitute.sink

        received_events = sink.received_events

        comment received_events.inspect

        received = received_events == [event_data]

        test "Received the event data" do
          assert(received)
        end
      end
    end
  end
end
