require_relative 'automated_init'

context "Events" do
  Controls::Events.each_example(random: true) do |event|
    *, control_event_type = event.class.name.split('::').map(&:to_sym)

    context "#{control_event_type}" do
      event_data = nil

      context "Dump Event" do
        event_data = event.dump

        comment event_data.inspect

        test! "Converted to text" do
          assert(event_data.is_a?(String))
        end
      end

      context "Load Data" do
        read_event = Telemetry::Event.load(event_data)

        test "Equivalent to the original event data" do
          assert(read_event == event)
        end

        context "Event Type" do
          event_type = read_event.event_type

          comment event_type.inspect
          detail "Control: #{control_event_type.inspect}"

          test do
            assert(event_type == control_event_type)
          end
        end

        context "Attributes" do
          attribute_names = event.members

          attribute_names.each do |attribute_name|
            context "#{attribute_name.inspect}" do
              value = read_event.public_send(attribute_name)

              comment value.inspect

              test do
                refute(value.nil?)
              end
            end
          end
        end
      end
    end
  end
end
