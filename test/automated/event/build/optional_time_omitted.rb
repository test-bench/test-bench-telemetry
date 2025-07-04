require_relative '../../automated_init'

context "Event" do
  context "Build" do
    context "Optional Time Omitted" do
      event = Controls::Event::SomeEvent.build(
        Controls::Event.some_attribute,
        Controls::Event.some_other_attribute,
        process_id: Controls::Event.process_id
      )

      context "Metadata" do
        metadata = event.metadata

        context "Time" do
          time = metadata.time

          comment time.inspect

          test "Set" do
            assert(time.instance_of?(Time))
          end
        end
      end
    end
  end
end
