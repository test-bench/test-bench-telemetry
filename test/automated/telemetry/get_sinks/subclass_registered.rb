require_relative '../../automated_init'

context "Get Sinks" do
  context "Subclass is Registered" do
    telemetry = Telemetry.new

    sink_class = Controls::Sink::Example
    subclass = Class.new(sink_class)

    sink = subclass.new
    telemetry.sinks << sink

    sinks = telemetry.get_sinks(Controls::Sink::Example)

    context "Not retrieved" do
      not_retrieved = sinks.empty?

      test do
        assert(not_retrieved)
      end
    end
  end
end
