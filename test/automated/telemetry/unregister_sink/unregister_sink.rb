require_relative '../../automated_init'

context "Telemetry" do
  context "Unregister Sink" do
    sink = Controls::Sink.example

    telemetry = Telemetry.new
    telemetry.register(sink)

    assert(telemetry.registered?(sink))

    telemetry.unregister(sink)

    context "Unregistered" do
      registered = telemetry.registered?(sink)

      comment "Registered: #{registered.inspect}"

      test do
        refute(registered)
      end
    end
  end
end
