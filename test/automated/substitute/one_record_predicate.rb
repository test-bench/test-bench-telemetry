require_relative '../automated_init'

context "Substitute" do
  context "One Record Predicate Methods" do
    other_type_event = Controls::Event.example

    events = Controls::Events.examples
    other_events = Controls::Events.examples(random: true)

    events.zip(other_events).each do |(event, other_event)|
      event_type = event.event_type

      event_type_method_cased = Telemetry::Event::Type.method_cased(event_type)

      one_record_predicate_method = :"one_#{event_type_method_cased}_record?"

      context "#{one_record_predicate_method}" do
        substitute = Telemetry::Substitute.build

        substitute.record(event)
        substitute.record(other_event)

        substitute.record(other_type_event)

        context "One Record Matches" do
          matches = substitute.public_send(one_record_predicate_method) do |*values|
            values != other_event.values
          end

          test do
            assert(matches)
          end
        end

        context "More Than One Record Matches" do
          test "Is an error" do
            assert_raises(Telemetry::Sink::Capture::MatchError) do
              substitute.public_send(one_record_predicate_method)
            end
          end
        end

        context "No Records Match" do
          matches = substitute.public_send(one_record_predicate_method) { false }

          test do
            refute(matches)
          end
        end
      end
    end
  end
end
