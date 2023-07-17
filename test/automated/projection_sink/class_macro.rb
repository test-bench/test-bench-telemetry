require_relative '../automated_init'

context "Projection Sink" do
  context "Class Macro" do
    projection = Controls::Projection.example

    apply_method = Controls::Projection::ApplyMethod.example

    context! "Implements an event projection" do
      implemented = projection.respond_to?(apply_method)

      test do
        assert(implemented)
      end
    end

    context "Registers event class" do
      registry = projection.class.event_registry

      registered = registry.registered?(Controls::Event::SomeEvent)

      test do
        assert(registered)
      end
    end

    context "Handle an Event" do
      refute(projection.applied?)

      event = Controls::Event.example

      projection.public_send(apply_method, event)

      test do
        assert(projection.applied?(event))
      end
    end
  end
end
