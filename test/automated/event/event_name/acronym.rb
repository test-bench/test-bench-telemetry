require_relative '../../automated_init'

context "Event" do
  context "Event Name" do
    context "Acronym" do
      event_class = Telemetry::Event.define do
        def self.name
          "SomeEventTypeWithAnACRONYM"
        end
      end

      event_name = event_class.event_name
      control_event_name = :some_event_type_with_an_acronym

      comment event_name.inspect
      detail "Control: #{control_event_name.inspect}"

      test do
        assert(event_name == control_event_name)
      end
    end
  end
end
