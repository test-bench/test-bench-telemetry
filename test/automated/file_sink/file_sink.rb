require_relative '../automated_init'

context "File Sink" do
  control_event_data = [
    Controls::EventData.example,
    Controls::EventData.random,
    Controls::EventData.random
  ]

  file_path = Controls::Path::File.example(basename: 'file-sink-test')

  file_sink = Telemetry::Sink::File.build(file_path)

  control_event_data.each do |event|
    file_sink.receive(event)
  end

  file_sink.file.close

  context "Read File Back" do
    file_contents = Controls::Path::File::Read.(file_path)

    detail file_contents

    text_lines = file_contents.each_line.to_a

    control_event_data.each_with_index do |event_data, index|
      context "Event ##{index + 1}: #{event_data.type}" do
        text = text_lines[index]

        comment text.inspect

        read_event_data = Telemetry::EventData.load(text)

        test do
          assert(read_event_data == event_data)
        end
      end
    end
  end

ensure
  File.unlink(file_path) if file_path && File.exist?(file_path)
end
