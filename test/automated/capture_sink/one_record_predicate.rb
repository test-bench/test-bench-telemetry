require_relative '../automated_init'

context "Capture Sink" do
  context "One Record Predicate" do
    capture_sink = Telemetry::Sink::Capture.new

    event_1 = Controls::Event.example('event-1-data')
    event_2 = Controls::Event.example('event-2-data')

    capture_sink.(event_1)
    capture_sink.(event_2)

    context "One Record Matches" do
      matches = capture_sink.one_record? do |_event_type, data|
        data == 'event-1-data'
      end

      test do
        assert(matches)
      end
    end

    context "More Than One Record Matches" do
      test "Is an error" do
        assert_raises(Telemetry::Sink::Capture::MatchError) do
          capture_sink.one_record? { true }
        end
      end
    end

    context "No Records Match" do
      matches = capture_sink.one_record? { false }

      test do
        refute(matches)
      end
    end
  end
end
