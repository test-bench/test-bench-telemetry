require_relative '../automated_init'

context "Event" do
  context "Case Equality" do
    context "Equal" do
      context "Instance of event" do
        event = Controls::Event.example

        equal = Controls::Event::SomeEvent === event

        test do
          assert(equal)
        end
      end

      context "Event data with corresponding type" do
        event_data = Controls::Event.event_data

        equal = Controls::Event::SomeEvent === event_data

        test do
          assert(equal)
        end
      end
    end

    context "Not Equal" do
      context "Instance of other event" do
        event = Controls::Event::Other.example

        equal = Controls::Event::SomeEvent === event

        test do
          refute(equal)
        end
      end

      context "Event data with other type" do
        event_data = Controls::Event::Other.event_data

        equal = Controls::Event::SomeEvent === event_data

        test do
          refute(equal)
        end
      end

      context "Other object" do
        object = Object.new

        equal = Controls::Event::SomeEvent === object

        test do
          refute(equal)
        end
      end
    end
  end
end
