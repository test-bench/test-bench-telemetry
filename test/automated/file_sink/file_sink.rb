require_relative '../automated_init'

context "File Sink" do
  path = Controls::File.random(basename: 'file-sink-test')

  file = File.open(path, 'w')
  file.sync = true

  file_sink = Telemetry::Sink::File.new(file)

  control_event_data = [
    Controls::EventData.example,
    Controls::EventData.random,
    Controls::EventData.random
  ]

  control_event_data.each do |event|
    file_sink.receive(event)
  end

  context "Open File" do
    File.open(path, 'r') do |read_file|
      context "Read File Back" do
        control_event_data.each_with_index do |event_data, index|
          context "Event ##{index + 1}: #{event_data.type}" do
            text = read_file.gets

            comment text.inspect

            read_event_data = Telemetry::EventData.load(text)

            test do
              assert(read_event_data == event_data)
            end
          end
        end
      end
    end
  end

ensure
  File.unlink(path) if File.exist?(path)
end
