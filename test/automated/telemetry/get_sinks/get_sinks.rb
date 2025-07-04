require_relative '../../automated_init'

context "Get Sinks" do
  telemetry = Telemetry.new

  2.times do
    sink = Controls::Sink.example
    telemetry.sinks << sink
  end

  other_sink = Controls::Sink.other_example
  telemetry.sinks << other_sink

  sinks = telemetry.get_sinks(Controls::Sink::Example)

  detail "Sinks: #{sinks.map(&:class).join(", ")}"

  context "Instances Of Given Class" do
    control_sinks = telemetry.sinks.select do |sink|
      sink.instance_of?(Controls::Sink::Example)
    end

    retrieved = sinks == control_sinks

    test "Retrieved" do
      assert(retrieved)
    end
  end

  context "Other Sink" do
    retrieved = sinks.include?(other_sink)

    test "Not retrieved" do
      refute(retrieved)
    end
  end
end
