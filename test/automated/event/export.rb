require_relative '../automated_init'

context "Event" do
  context "Export" do
    event = Controls::Event.example

    event_data = Telemetry::Event::Export.(event)

    detail "Event: #{event.inspect}"
    detail "Event Data: #{event_data.inspect}"

    context "Exported Event Data" do
      test! do
        assert(event_data.instance_of?(Telemetry::EventData))
      end

      context "Type" do
        type = event_data.type
        event_type = event.event_type

        comment type.inspect
        detail "Event Type: #{event_type.inspect}"

        test do
          assert(type == event_type)
        end
      end

      context "Data" do
        data = event_data.data
        control_data = Controls::Event::Data.example

        comment data.inspect
        detail "Control Data: #{control_data.inspect}"

        test do
          assert(data == control_data)
        end
      end

      context "Process ID" do
        process_id = event_data.process_id
        metadata_process_id = event.metadata.process_id

        comment process_id.inspect
        detail "Metadata Process ID: #{metadata_process_id}"

        test do
          assert(process_id == metadata_process_id)
        end
      end

      context "Time" do
        time = event_data.time
        metadata_time = event.metadata.time

        comment time.inspect
        detail "Metadata Time: #{metadata_time}"

        test do
          assert(time == metadata_time)
        end
      end
    end
  end
end
