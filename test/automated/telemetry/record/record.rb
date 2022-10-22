require_relative '../../automated_init'

context "Telemetry" do
  context "Record" do
    control_data = Controls::Random.string
    event = Controls::Event.example(control_data)

    sink_1 = Telemetry::Sink::Capture.new
    sink_2 = Telemetry::Sink::Capture.new

    telemetry = Telemetry.new

    telemetry.register(sink_1)
    telemetry.register(sink_2)

    telemetry.record(event)

    context "First Sink" do
      received_event = sink_1.one_record? do |event_type, data|
        event_type == event.event_type && data == control_data
      end

      test "Receives the event" do
        assert(received_event)
      end
    end

    context "Second Sink" do
      received_event = sink_2.one_record? do |event_type, data|
        event_type == event.event_type && data == control_data
      end

      test "Receives the event" do
        assert(received_event)
      end
    end
  end
end
