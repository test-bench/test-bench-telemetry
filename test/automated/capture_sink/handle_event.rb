require_relative '../automated_init'

context "Capture Sink" do
  context "Handle Event" do
    capture_sink = Telemetry::Sink::Capture.new

    generate_record = Telemetry::Sink::Capture::Record::Generate.new
    capture_sink.generate_record = generate_record

    control_path = Controls::CaptureSink::Path.example
    generate_record.path = control_path

    control_detail_level = Controls::DetailLevel.example
    generate_record.detail_level = control_detail_level

    control_event = Controls::Event.example

    capture_sink.(control_event)

    context "Raw Records" do
      records = capture_sink.raw_records

      context! "Count" do
        count = records.count

        comment count.inspect

        test "One record" do
          assert(count == 1)
        end
      end

      context "One Record" do
        record = records.first

        comment record.class.inspect

        test! do
          assert(record.is_a?(Telemetry::Sink::Capture::Record))
        end

        context "Event" do
          event = record.event

          comment event.inspect
          detail "Control: #{control_event.inspect}"

          test do
            assert(event == control_event)
          end
        end

        context "Path" do
          path_segments = record.path.segments

          comment "Segments: #{path_segments.inspect}"

          copied = record.path.copy?(control_path)

          test "Copied" do
            assert(copied)
          end
        end

        context "Detail Level" do
          detail_level = record.detail_level

          comment detail_level.inspect
          detail "Control: #{control_detail_level.inspect}"

          test do
            assert(detail_level == control_detail_level)
          end
        end
      end
    end
  end
end
