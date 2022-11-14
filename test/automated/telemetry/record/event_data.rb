require_relative '../../automated_init'

context "Telemetry" do
  context "Record" do
    context "Event Data" do
      control_event_data = Controls::EventData.example

      sink_1 = Controls::Sink.example
      sink_2 = Controls::Sink.example

      telemetry = Telemetry.new

      telemetry.sinks = [sink_1, sink_2]

      event_data = telemetry.record(control_event_data)

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
