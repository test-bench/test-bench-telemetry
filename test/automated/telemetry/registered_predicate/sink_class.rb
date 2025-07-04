require_relative '../../automated_init'

context "Registered Predicate" do
  context "Sink Class Argument" do
    cls = Controls::Sink::Example

    context "Registered" do
      sink = Controls::Sink.example

      telemetry = Telemetry.new
      telemetry.sinks << sink

      registered = telemetry.registered?(cls)

      comment registered.inspect

      test do
        assert(registered)
      end
    end

    context "Not Registered" do
      sink = Controls::Sink.other_example

      telemetry = Telemetry.new
      telemetry.sinks << sink

      registered = telemetry.registered?(cls)

      comment registered.inspect

      test do
        refute(registered)
      end
    end
  end
end
