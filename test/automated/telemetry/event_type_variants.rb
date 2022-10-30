require_relative '../automated_init'

context "Telemetry" do
  context "Event Type Variants" do
    Controls::Events.each_example do |event|
      event_type = event.event_type

      telemetry = Telemetry.new

      capture_sink = Telemetry::Sink::Capture.new
      telemetry.register(capture_sink)

      event_type_method_cased = Telemetry::Event::Type.method_cased(event_type)
      method_name = :"record_#{event_type_method_cased}"

      context "#{method_name}" do
        context "Event: #{event_type}" do
          telemetry.public_send(method_name, *event.values)

          published = capture_sink.one_record? do |event_type, *values|
            event_type == event.event_type && values == event.values
          end

          test do
            assert(published)
          end
        end
      end
    end
  end
end
