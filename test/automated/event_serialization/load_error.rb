require_relative '../automated_init'

context "Event Serialization" do
  context "Load Error" do
    event_namespace = Controls::Event

    context "Malformed Data" do
      [
        ["Empty String", :Empty],
        ["No Data", :NoData],
        ["Incorrect Event Type", :IncorrectEventType],
        ["Incorrect Newlines", :IncorrectNewlines]
      ].each do |(context_title, constant)|
        control = Controls::Event::Data::Malformed.const_get(constant)

        context context_title do
          data = control.example

          test "Is an error" do
            assert_raises(Telemetry::Event::Serialization::Error) do
              Telemetry::Event.load(data, event_namespace)
            end
          end
        end
      end
    end

    context "Unknown Event" do
      unknown_event_type = Controls::Event::Type.random

      data = Controls::Event::Data.example(event_type: unknown_event_type)

      test "Is an error" do
        assert_raises(Telemetry::Event::Serialization::Error) do
          Telemetry::Event.load(data, event_namespace)
        end
      end
    end
  end
end
