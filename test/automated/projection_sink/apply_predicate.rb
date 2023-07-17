require_relative '../automated_init'

context "Projection Sink" do
  context "Handle Predicate" do
    projection = Controls::Projection.example

    context "Projection Implements Event Projection for Event" do
      event = Controls::Event.example

      handles = projection.apply?(event)

      test "Handles" do
        assert(handles)
      end
    end

    context "Projection Doesn't Implement Event Projection for Event" do
      event = Controls::Event.other_example

      handles = projection.apply?(event)

      test "Doesn't handle" do
        refute(handles)
      end
    end
  end
end
