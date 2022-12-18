require_relative '../automated_init'

context "Event Data" do
  context "Load Error" do
    [
      ["Empty String", Controls::EventData::Text::Malformed::Empty],
      ["Incorrect Event Type", Controls::EventData::Text::Malformed::IncorrectEventType],
      ["Incorrect Newlines", Controls::EventData::Text::Malformed::IncorrectNewlines]
    ].each do |(context_title, control)|
      context context_title do
        text = control.example

        test "Is an error" do
          assert_raises(Telemetry::EventData::Serialization::Error) do
            Telemetry::EventData.load(text)
          end
        end
      end
    end
  end
end
