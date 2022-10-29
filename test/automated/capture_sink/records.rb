require_relative '../automated_init'

context "Capture Sink" do
  context "Records" do
    capture_sink = Telemetry::Sink::Capture.new

    event_1 = Controls::Event.example('event-1-data')
    event_2 = Controls::Event.example('event-2-data')
    event_3 = Controls::Event.example('event-3-data')

    capture_sink.(event_1)
    capture_sink.(event_2)
    capture_sink.(event_3)

    context "Gets all matching records" do
      records = capture_sink.records do |_event_type, data|
        data == 'event-1-data' || data == 'event-2-data'
      end

      recorded_events = records.map(&:event)

      test do
        assert(recorded_events == [event_1, event_2])
      end
    end
  end
end
