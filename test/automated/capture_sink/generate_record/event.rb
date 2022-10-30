require_relative '../../automated_init'

context "Capture Sink" do
  context "Generate Record" do
    context "Event" do
      Controls::Events.each_example do |control_event|
        event_type = control_event.event_type

        context "#{event_type}" do
          generate_record = Telemetry::Sink::Capture::Record::Generate.new

          record = generate_record.(control_event)

          context "Record's Event" do
            event = record.event

            comment event.inspect
            detail "Control: #{control_event.inspect}"

            test do
              assert(event == control_event)
            end
          end
        end
      end
    end
  end
end
