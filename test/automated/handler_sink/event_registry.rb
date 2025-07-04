require_relative '../automated_init'

context "Handler Sink" do
  context "Event Registry" do
    registry = Telemetry::Sink::Handler::EventRegistry.new
    event_class = Controls::Event::SomeEvent
    other_event_class = Controls::Event::SomeOtherEvent

    registry.register(event_class)
    registry.register(other_event_class)

    context! "Registered" do
      registered = registry.registered?(event_class)

      test do
        assert(registered)
      end
    end

    context "Register Event Class More than Once" do
      test "Is an error" do
        assert_raises(Telemetry::Sink::Handler::EventRegistry::Error) do
          registry.register(event_class)
        end
      end
    end

    context "Retrieve Event Class by Event Type" do
      context "Registered" do
        event_type = event_class.event_type

        retrieved_event_class = registry.get(event_class.event_type)

        comment retrieved_event_class.to_s
        detail "Event Type: #{event_type.inspect}"

        test do
          assert(retrieved_event_class == event_class)
        end
      end

      context "Not Registered" do
        event_type = Controls::EventData::Type.random

        detail "Event Type: #{event_type.inspect}"

        test "Is an error" do
          assert_raises(Telemetry::Sink::Handler::EventRegistry::Error) do
            registry.get(event_type)
          end
        end
      end
    end

    context "Event Types" do
      event_types = registry.event_types
      control_event_types = [:SomeEvent, :SomeOtherEvent]

      comment event_types.inspect
      detail "Control: #{control_event_types.inspect}"

      test do
        assert(event_types == control_event_types)
      end
    end
  end
end
