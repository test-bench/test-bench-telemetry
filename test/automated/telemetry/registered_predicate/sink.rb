require_relative '../../automated_init'

context "Registered Predicate" do
  context "Sink Argument" do
    control_sink = Controls::Sink.example

    telemetry = Telemetry.new

    telemetry.sinks << control_sink

    context "Registered" do
      sink = control_sink

      registered = telemetry.registered?(sink)

      comment registered.inspect

      test do
        assert(registered)
      end
    end

    context "Not Registered" do
      sink = Controls::Sink.example

      registered = telemetry.registered?(sink)

      comment registered.inspect

      test do
        refute(registered)
      end
    end
  end
end
