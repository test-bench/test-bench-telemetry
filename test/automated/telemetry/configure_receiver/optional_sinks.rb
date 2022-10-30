require_relative '../../automated_init'

context "Telemetry" do
  context "Configure Receiver" do
    context "Optional Sinks Given" do
      sink_1 = Controls::Sink.example
      sink_2 = Controls::Sink.example

      receiver = Struct.new(:telemetry).new

      Telemetry.configure(receiver, sink_1, sink_2)

      telemetry = receiver.telemetry

      context "First Sink" do
        registered = telemetry.registered?(sink_1)

        test "Registered" do
          assert(registered)
        end
      end

      context "Second Sink" do
        registered = telemetry.registered?(sink_2)

        test "Registered" do
          assert(registered)
        end
      end
    end
  end
end
