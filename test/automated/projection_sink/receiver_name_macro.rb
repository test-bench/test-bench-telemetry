require_relative '../automated_init'

context "Projection Sink" do
  context "Receiver Name Macro" do
    receiver = Controls::Projection::Receiver.example

    projection = Controls::Projection::Example.new(receiver)

    test "Defines an accessor for the receiver" do
      assert(projection.respond_to?(:some_receiver))
    end

    test "Accesses the receiver" do
      assert(projection.some_receiver == receiver)
    end
  end
end
