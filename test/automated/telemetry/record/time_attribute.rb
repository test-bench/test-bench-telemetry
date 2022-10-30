require_relative '../../automated_init'

context "Telemetry" do
  context "Record" do
    context "Event's Time Attribute" do
      now = Controls::Time.random

      context "Not Already Set" do
        event = Controls::Event.example
        event.time = nil

        telemetry = Telemetry.new

        telemetry.record(event, now)

        test "Set to current time" do
          assert(event.time == now)
        end
      end

      context "Already Set" do
        time = Controls::Time.example
        event = Controls::Event.example(time:)

        telemetry = Telemetry.new

        telemetry.record(event, now)

        test "Remains unchanged" do
          assert(event.time == time)
        end
      end
    end
  end
end
