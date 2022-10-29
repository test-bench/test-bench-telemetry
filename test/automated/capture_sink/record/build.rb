require_relative '../../automated_init'

context "Capture Sink" do
  context "Record" do
    context "Build" do
      control_event = Controls::Event.example
      control_path = Controls::CaptureSink::Path.example
      control_detail_level = Controls::DetailLevel.example

      record = Telemetry::Sink::Capture::Record.build(control_event, control_path, control_detail_level)

      context "Event" do
        event = record.event

        comment event.inspect
        detail "Control: #{control_event.inspect}"

        test do
          assert(event == control_event)
        end
      end

      context "Path" do
        path = record.path

        copied = path.copy?(control_path)

        test "Copied from original path" do
          assert(copied)
        end
      end

      context "Detail Level" do
        detail_level = record.detail_level

        comment detail_level.inspect
        detail "Control: #{detail_level.inspect}"

        test do
          assert(detail_level == control_detail_level)
        end
      end
    end
  end
end
