require_relative '../../automated_init'

context "Sink" do
  context "Receive Event" do
    context "Not Implemented" do
      cls = Class.new do
        include Telemetry::Sink

        def self.name = "SomeSink"
      end

      sink = cls.new

      event_data = Controls::EventData.example

      test "Is an error" do
        assert_raises(Telemetry::Sink::ReceiveError) do
          sink.receive(event_data)
        end
      end
    end
  end
end
