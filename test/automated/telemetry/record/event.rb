require_relative '../../automated_init'

context "Telemetry" do
  context "Record" do
    context "Event" do
      event = Controls::Event.example

      sink_1 = Controls::Sink.example
      sink_2 = Controls::Sink.example

      telemetry = Telemetry.new

      telemetry.sinks = [sink_1, sink_2]

      event_data = telemetry.record(event)

      test! do
        assert(event_data.instance_of?(Telemetry::EventData))
      end

      context "First Sink" do
        received_event = sink_1.received?(event_data)

        test "Receives the event" do
          assert(received_event)
        end
      end

      context "Second Sink" do
        received_event = sink_2.received?(event_data)

        test "Receives the event" do
          assert(received_event)
        end
      end
    end
  end
end
