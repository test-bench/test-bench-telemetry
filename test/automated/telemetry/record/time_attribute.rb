require_relative '../../automated_init'

context "Telemetry" do
  context "Record" do
    context "Time Attribute" do
      current_time = ::Time.now

      context "Not Already Set On Event's Metadata" do
        event = Controls::Event.example(time: :none)

        telemetry = Telemetry.new

        event_data = telemetry.record(event)

        test "Set to current time" do
          assert(event_data.time > current_time)
        end
      end

      context "Already Set On Event's Metadata" do
        time = Controls::Time.example
        event = Controls::Event.example(time:)

        telemetry = Telemetry.new

        event_data = telemetry.record(event)

        test "Is the event's time" do
          assert(event_data.time == time)
        end
      end
    end
  end
end
