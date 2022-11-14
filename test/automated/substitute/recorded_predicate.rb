require_relative '../automated_init'

context "Substitute" do
  context "Recorded Predicate" do
    event_data = Controls::EventData.example

    substitute = Telemetry::Substitute.build

    substitute.record(event_data)

    context "Recorded" do
      recorded = substitute.recorded?(event_data)

      test do
        assert(recorded)
      end
    end

    context "Not Recorded" do
      other_event_data = Controls::EventData.random

      recorded = substitute.recorded?(other_event_data)

      test do
        refute(recorded)
      end
    end
  end
end
