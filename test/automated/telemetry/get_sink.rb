require_relative '../automated_init'

context "Get Sink" do
  telemetry = Telemetry.new

  control_sink = Controls::Sink.example
  telemetry.sinks << control_sink

  2.times do
    other_sink = Controls::Sink.other_example
    telemetry.sinks << other_sink
  end

  context "One Match" do
    sink_class = Controls::Sink::Example

    sink = telemetry.get_sink(sink_class)

    retrieved = sink == control_sink

    test "Retrieved" do
      assert(retrieved)
    end
  end

  context "No Match" do
    sink_class = Class.new(Controls::Sink::Example)

    sink = telemetry.get_sink(sink_class)

    test "Not retrieved" do
      assert(sink.nil?)
    end
  end

  context "Multiple Matches" do
    sink_class = Controls::Sink::OtherExample

    test "Is an error" do
      assert_raises(Telemetry::GetError) do
        telemetry.get_sink(sink_class)
      end
    end
  end
end
