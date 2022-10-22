require_relative '../../automated_init'

context "Telemetry" do
  context "Register Sink" do
    sink = Controls::Sink.example

    telemetry = Telemetry.new

    refute(telemetry.registered?(sink))

    telemetry.register(sink)

    context "Registered" do
      registered = telemetry.registered?(sink)

      comment registered.inspect

      test do
        assert(registered)
      end
    end
  end
end
