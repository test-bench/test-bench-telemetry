require_relative '../../automated_init'

context "Event" do
  context "Import" do
    event_data = Controls::Event.event_data

    context "Incorrect Event Type" do
      test "Is an error" do
        assert_raises(Telemetry::Event::Import::Error) do
          Telemetry::Event::Import.(event_data, Controls::Event::SomeOtherEvent)
        end
      end
    end
  end
end
