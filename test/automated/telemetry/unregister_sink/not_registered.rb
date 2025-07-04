require_relative '../../automated_init'

context "Telemetry" do
  context "Unregister Sink" do
    context "Not Registered" do
      sink = Controls::Sink.example

      telemetry = Telemetry.new

      refute(telemetry.registered?(sink))

      test "Is an error" do
        assert_raises(Telemetry::RegistrationError) do
          telemetry.unregister(sink)
        end
      end
    end
  end
end
