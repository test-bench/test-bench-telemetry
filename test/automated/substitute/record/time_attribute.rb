require_relative '../../automated_init'

context "Substitute" do
  context "Record Event" do
    context "Time Attribute" do
      time = Controls::Time.example

      context "Not Already Set On Event's Metadata" do
        event = Controls::Event.example(time: :none)

        substitute = Telemetry::Substitute.build
        substitute.current_time = time

        event_data = substitute.record(event)

        test "Set to substitute's current time" do
          assert(event_data.time == time)
        end
      end

      context "Already Set On Event's Metadata" do
        event_time = Controls::Time.random
        event = Controls::Event.example(time: event_time)

        substitute = Telemetry::Substitute.build
        substitute.current_time = time

        event_data = substitute.record(event)

        test "Is the event's time" do
          assert(event_data.time == event_time)
        end
      end
    end
  end
end
