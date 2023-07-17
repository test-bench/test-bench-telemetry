require_relative '../../automated_init'

context "Sink" do
  context "Receive Event" do
    context "Implemented" do
      sink = Controls::Sink.example

      event_data = Controls::EventData.example

      sink.receive(event_data)

      test do
        assert(sink.received?(event_data))
      end
    end
  end
end
