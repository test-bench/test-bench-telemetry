require_relative '../automated_init'

context "Handler Sink" do
  context "Handle Predicate" do
    handler = Controls::Handler.example

    context "Handler Implements Event Handler for Event" do
      event = Controls::Event.example

      handles = handler.handle?(event)

      test "Handles" do
        assert(handles)
      end
    end

    context "Handler Doesn't Implement Event Handler for Event" do
      event = Controls::Event.other_example

      handles = handler.handle?(event)

      test "Doesn't handle" do
        refute(handles)
      end
    end
  end
end
