require_relative '../automated_init'

context "Substitute" do
  context "Any Record Predicate Methods" do
    other_type_event = Controls::Event.example

    events = Controls::Events.examples
    other_events = Controls::Events.examples(random: true)

    events.zip(other_events).each do |(event, other_event)|
      event_type = event.event_type

      event_type_method_cased = Telemetry::Event::Type.method_cased(event_type)

      any_record_method = :"#{event_type_method_cased}_record?"

      context "#{any_record_method}" do
        substitute = Telemetry::Substitute.build

        substitute.record(event)
        substitute.record(other_event)
        substitute.record(other_type_event)

        context "Block Given" do
          context "Any Records Match" do
            any_record = substitute.public_send(any_record_method) do |*values|
              values == event.values
            end

            comment any_record.inspect

            test do
              assert(any_record)
            end
          end

          context "No Records Match" do
            any_record = substitute.public_send(any_record_method) { false }

            comment any_record.inspect

            test do
              refute(any_record)
            end
          end
        end

        context "Block Omitted" do
          any_record = substitute.public_send(any_record_method)

          comment any_record.inspect

          test do
            assert(any_record)
          end
        end
      end
    end
  end
end
