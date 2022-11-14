require_relative '../automated_init'

context "Substitute Sink" do
  context "Received Predicate" do
    event_data = Controls::EventData.example

    substitute = Telemetry::Substitute::Sink.new

    substitute.receive(event_data)

    context "Received" do
      received = substitute.received?(event_data)

      test do
        assert(received)
      end
    end

    context "Not Received" do
      other_event_data = Controls::EventData.random

      received = substitute.received?(other_event_data)

      test do
        refute(received)
      end
    end
  end
end
