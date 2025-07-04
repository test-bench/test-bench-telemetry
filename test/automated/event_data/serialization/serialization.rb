require_relative '../../automated_init'

context "Event Data" do
  context "Serialization" do
    control_event_data = Controls::EventData.example
    control_text = Controls::EventData::Text.example

    context "Dump" do
      text = control_event_data.dump

      comment text.inspect
      detail "Serialized: #{control_text.inspect}"

      test do
        assert(text == control_text)
      end
    end

    context "Load" do
      event_data = Telemetry::EventData.load(control_text)

      comment event_data.inspect
      detail "Original Event Data: #{control_event_data.inspect}"

      test do
        assert(event_data == control_event_data)
      end
    end
  end
end
