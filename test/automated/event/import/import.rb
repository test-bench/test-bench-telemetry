require_relative '../../automated_init'

context "Event" do
  context "Import" do
    event_data = Controls::Event.event_data

    event = Telemetry::Event::Import.(event_data, Controls::Event::SomeEvent)

    detail "Event Data: #{event_data.inspect}"
    detail "Event: #{event.inspect}"

    context "Imported Event" do
      test! do
        assert(event.instance_of?(Controls::Event::SomeEvent))
      end

      context "Event Type" do
        event_type = event.event_type
        event_data_type = event_data.type

        comment event_type.inspect
        detail "Event Data Type: #{event_data_type.inspect}"

        test do
          assert(event_type == event_data_type)
        end
      end

      context "Data" do
        data = event.data
        control_data = Controls::Event::Data.example

        comment data.inspect
        detail "Control Data: #{control_data.inspect}"

        test do
          assert(data == control_data)
        end
      end

      context "Metadata" do
        metadata = event.metadata

        context "Process ID" do
          process_id = metadata.process_id
          event_data_process_id = event_data.process_id

          comment process_id.inspect
          detail "Event Data Process ID: #{event_data_process_id}"

          test do
            assert(process_id == event_data_process_id)
          end
        end

        context "Time" do
          time = metadata.time
          event_data_time = event_data.time

          comment time.inspect
          detail "Event Data Time: #{event_data_time}"

          test do
            assert(time == event_data_time)
          end
        end
      end
    end
  end
end
