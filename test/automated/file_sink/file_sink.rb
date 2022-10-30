require_relative '../automated_init'

context "File Sink" do
  path = Controls::Path::Temporary.random(basename: 'file-sink-test')

  file = File.open(path, 'w')
  file.sync = true

  file_sink = Telemetry::Sink::File.new(file)

  control_events = Controls::Events.examples(random: true)

  control_events.each do |event|
    file_sink.(event)
  end

  context "Read File Back" do
    File.open(path, 'r') do |read_file|
      control_events.each do |control_event|
        context "#{control_event.event_type}" do
          data = read_file.gets

          comment data.inspect

          event = Telemetry::Event.load(data)

          test do
            assert(event == control_event)
          end
        end
      end
    end
  end

ensure
  File.unlink(path) if File.exist?(path)
end
