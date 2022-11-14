require_relative '../../automated_init'

context "Telemetry" do
  context "Record" do
    context "Process ID Attribute" do
      current_process_id = ::Process.pid

      context "Not Already Set On Event's Metadata" do
        event = Controls::Event.example(process_id: :none)

        telemetry = Telemetry.new

        event_data = telemetry.record(event)

        test "Set to current process ID" do
          assert(event_data.process_id == current_process_id)
        end
      end

      context "Already Set On Event's Metadata" do
        process_id = Controls::ProcessID.random
        event = Controls::Event.example(process_id:)

        telemetry = Telemetry.new

        event_data = telemetry.record(event)

        test "Is the event's process ID" do
          assert(event_data.process_id == process_id)
        end
      end
    end
  end
end
