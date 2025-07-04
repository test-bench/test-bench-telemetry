require_relative '../../automated_init'

context "Substitute" do
  context "Record Event" do
    context "Event" do
      substitute = Telemetry::Substitute.build

      event = Controls::Event.example
      detail "Event: #{event.inspect}"

      event_data = substitute.record(event)

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
