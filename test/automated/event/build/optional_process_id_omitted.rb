require_relative '../../automated_init'

context "Event" do
  context "Build" do
    context "Optional Process ID Omitted" do
      current_process_id = Controls::ProcessID.current_process

      event = Controls::Event::SomeEvent.build(
        Controls::Event.some_attribute,
        Controls::Event.some_other_attribute,
        time: Controls::Event.time
      )

      context "Metadata" do
        metadata = event.metadata

        context "Process ID" do
          process_id = metadata.process_id

          comment process_id.inspect
          detail "Current: #{current_process_id.inspect}"

          test "Set to the current process ID" do
            assert(process_id == current_process_id)
          end
        end
      end
    end
  end
end
