require_relative '../../automated_init'

context "Substitute" do
  context "Record" do
    context "Process ID Attribute" do
      process_id = Controls::ProcessID.example

      context "Not Already Set On Event's Metadata" do
        event = Controls::Event.example(process_id: :none)

        substitute = Telemetry::Substitute.build
        substitute.process_id = process_id

        event_data = substitute.record(event)

        test "Set to substitute's process ID" do
          assert(event_data.process_id == process_id)
        end
      end

      context "Already Set On Event's Metadata" do
        event_process_id = Controls::ProcessID.random
        event = Controls::Event.example(process_id: event_process_id)

        substitute = Telemetry::Substitute.build
        substitute.process_id = process_id

        event_data = substitute.record(event)

        test "Is the event's process ID" do
          assert(event_data.process_id == event_process_id)
        end
      end
    end
  end
end
