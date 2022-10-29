require_relative '../../automated_init'

context "Capture Sink" do
  context "Record" do
    context "Match Predicate" do
      event = Controls::Event.example

      control_detail_level = Controls::DetailLevel.example
      control_detail = control_detail_level > 0

      control_segments = ['segment-1', 'segment-2', 'segment-3']
      path = Controls::CaptureSink::Path.example(control_segments)

      record = Controls::CaptureSink::Record.example(event:, path:, detail_level: control_detail_level)

      context "Matches" do
        detail, detail_level = control_detail, control_detail_level
        matches = record.match?(*control_segments, detail:, detail_level:) do |event_type, *values|
          event_type == event.event_type && values == event.values
        end

        test do
          assert(matches)
        end
      end

      context "Doesn't Match" do
        context "Path Segments Don't Match" do
          other_segment = Controls::Random.string

          detail, detail_level = control_detail, control_detail_level
          matches = record.match?(other_segment, detail:, detail_level:) do |event_type, *values|
            event_type == event.event_type && values == event.values
          end

          test "Doesn't match" do
            refute(matches)
          end
        end

        context "Detail Argument Doesn't Match" do
          detail = !control_detail

          detail_level = control_detail_level
          matches = record.match?(*control_segments, detail:, detail_level:) do |event_type, *values|
            event_type == event.event_type && values == event.values
          end

          test "Doesn't match" do
            refute(matches)
          end
        end

        context "Detail Level Doesn't Match" do
          detail_level = control_detail_level + 1

          detail = control_detail
          matches = record.match?(*control_segments, detail:, detail_level:) do |event_type, *values|
            event_type == event.event_type && values == event.values
          end

          test "Doesn't match" do
            refute(matches)
          end
        end

        context "Block Doesn't Indicate A Match" do
          detail, detail_level = control_detail, control_detail_level
          matches = record.match?(*control_segments, detail:, detail_level:) { false }

          test "Doesn't match" do
            refute(matches)
          end
        end
      end
    end
  end
end
