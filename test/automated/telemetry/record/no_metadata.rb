require_relative '../../automated_init'

context "Telemetry" do
  context "Record" do
    context "Event Doesn't Have Metadata" do
      event = Controls::Event::SomeEvent.new

      telemetry = Telemetry.new

      event_data = telemetry.record(event)

      test! do
        assert(event_data.instance_of?(Telemetry::EventData))
      end

      context "Process ID" do
        process_id = event_data.process_id

        test "Set" do
          refute(process_id.nil?)
        end
      end

      context "Time" do
        time = event_data.time

        test "Set" do
          refute(time.nil?)
        end
      end
    end
  end
end
