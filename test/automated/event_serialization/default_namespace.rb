require_relative '../automated_init'

context "Event Serialization" do
  context "Default Namespace" do
    event_type = Controls::Event::Type.example

    control_data = Controls::Event::Data.example(event_type:)

    refute(Telemetry::Event.const_defined?(event_type, false))

    *attributes, _time = Controls::Event::Example.members 
    event_class = Telemetry::Event.define(*attributes)

    context do
      Telemetry::Event::Events.const_set(event_type, event_class)

      context "Load Data" do
        event = Telemetry::Event.load(control_data)

        loaded = event.instance_of?(event_class)

        test "Loaded" do
          assert(loaded)
        end
      end

    ensure
      Telemetry::Event::Events.class_exec { remove_const(event_type) }
    end
  end
end
