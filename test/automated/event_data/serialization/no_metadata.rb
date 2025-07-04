require_relative '../../automated_init'

context "Event Data" do
  context "No Metadata" do
    control_event_data = Controls::EventData.example(process_id: :none, time: :none)

    text = nil

    context! "Dump" do
      test "Isn't an error" do
        refute_raises do
          text = control_event_data.dump
        end
      end

      comment "Text: #{text.inspect}"
    end

    context "Load" do
      event_data = Telemetry::EventData.load(text)

      comment event_data.inspect
      detail "Original Event Data: #{control_event_data.inspect}"

      test do
        assert(event_data == control_event_data)
      end
    end
  end
end
