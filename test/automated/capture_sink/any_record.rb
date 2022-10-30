require_relative '../automated_init'

context "Capture Sink" do
  context "Any Record Predicate" do
    capture_sink = Telemetry::Sink::Capture.new

    event_1 = Controls::Event.example('event-1-data')
    event_2 = Controls::Event.example('event-2-data')
    event_3 = Controls::Event.example('event-3-data')

    capture_sink.(event_1)
    capture_sink.(event_2)
    capture_sink.(event_3)

    context "Any Records Match" do
      any_record = capture_sink.record? do |_event_type, data|
        data == 'event-1-data' || data == 'event-2-data'
      end

      comment any_record.inspect

      test do
        assert(any_record)
      end
    end

    context "No Records Match" do
      any_record = capture_sink.record? { false }

      comment any_record.inspect

      test do
        refute(any_record)
      end
    end
  end
end
