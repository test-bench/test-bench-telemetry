require_relative '../automated_init'

context "Event Type" do
  context "Method Casing" do
    context do
      event_type = :SomeEventType
      control_event_type = :some_event_type

      event_type = Telemetry::Event::Type.method_cased(event_type)

      comment event_type.inspect
      detail "Underscore Cased: #{control_event_type.inspect}"

      test do
        assert(event_type == control_event_type)
      end
    end

    context "Acronym" do
      event_type = :SomeEventTypeWithAnACRONYM
      control_event_type = :some_event_type_with_an_acronym

      event_type = Telemetry::Event::Type.method_cased(event_type)

      comment event_type.inspect
      detail "Underscore Cased: #{control_event_type.inspect}"

      test do
        assert(event_type == control_event_type)
      end
    end
  end
end
