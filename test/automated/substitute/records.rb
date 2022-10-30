require_relative '../automated_init'

context "Substitute" do
  context "Records Methods" do
    other_type_event = Controls::Event.example

    events = Controls::Events.examples
    other_events = Controls::Events.examples(random: true)

    events.zip(other_events).each do |(event, other_event)|
      event_type = event.event_type

      event_type_method_cased = Telemetry::Event::Type.method_cased(event_type)

      records_method = :"#{event_type_method_cased}_records"

      context "#{records_method}" do
        substitute = Telemetry::Substitute.build

        substitute.record(event)
        substitute.record(other_event)
        substitute.record(other_type_event)

        context "Block Given" do
          records = substitute.public_send(records_method) do |*values|
            values == event.values
          end

          matches = records.count
          comment "Matches: #{matches}"

          test do
            assert(matches == 1)
          end
        end

        context "Block Omitted" do
          records = substitute.public_send(records_method)

          matches = records.count
          comment "Matches: #{matches}"

          test do
            assert(matches == 2)
          end
        end
      end
    end
  end
end
