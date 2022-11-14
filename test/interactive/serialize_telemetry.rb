require_relative 'interactive_init'

events = ENV.fetch('EVENTS', '1').to_i

puts <<~TEXT

Serialize Telemetry
= = =

Events: #{events}

TEXT

reader, writer = IO.pipe

writer_sink = TestBench::Telemetry::Sink::File.new(writer)
telemetry = TestBench::Telemetry.build(writer_sink)

puts <<~TEXT
Writing telemetry
- - -
TEXT

events.times do
  event = Controls::Event.random

  telemetry.record(event)

  puts "Wrote event: #{event.inspect}"
end
writer.close

puts <<~TEXT

Reading telemetry back
- - -
TEXT

until reader.eof?
  data = reader.read

  data.each_line do |event_text|
    event_data = TestBench::Telemetry::EventData.load(event_text)

    event_type = event_data.type
    event_class = Controls::Event.const_get(event_type)

    event = TestBench::Telemetry::Event::Import.(event_data, event_class)
    puts "Read event: #{event.inspect}"
  end
end
reader.close

puts <<~TEXT

(done)
- - -

TEXT
