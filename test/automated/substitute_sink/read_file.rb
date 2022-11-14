require_relative '../automated_init'

context "Substitute Sink" do
  context "Read File" do
    path = Controls::File::Temporary.example

    event_data_1 = Controls::EventData.example
    event_data_2 = Controls::EventData.random

    file_text = event_data_1.dump + event_data_2.dump
    File.write(path, file_text)

    substitute_sink = Telemetry::Substitute::Sink.read(path)

    context "Received Events" do
      received_events = substitute_sink.received_events

      context "First Event Data" do
        event_data = received_events[0]

        comment event_data.inspect
        detail "Control: #{event_data_1.inspect}"

        test do
          assert(event_data == event_data_1)
        end
      end

      context "Second Event Data" do
        event_data = received_events[1]

        comment event_data.inspect
        detail "Control: #{event_data_2.inspect}"

        test do
          assert(event_data == event_data_2)
        end
      end
    end
  end
end
