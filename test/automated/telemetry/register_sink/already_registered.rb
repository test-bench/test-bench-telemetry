require_relative '../../automated_init'

context "Telemetry" do
  context "Register Sink" do
    context "Already Registered" do
      sink = Controls::Sink.example

      telemetry = Telemetry.new

      telemetry.register(sink)

      test "Is an error" do
        assert_raises(Telemetry::RegistrationError) do
          telemetry.register(sink)
        end
      end
    end
  end
end
