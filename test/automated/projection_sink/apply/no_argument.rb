require_relative '../../automated_init'

context "Projection Sink" do
  context "Apply Event" do
    context "Projection Method Doesn't Accept An Argument" do
      projection = Controls::Projection::NoArgument.example

      event = Controls::Event.example

      projection.apply(event)

      test "Event is applied" do
        assert(projection.applied?)
      end
    end
  end
end
