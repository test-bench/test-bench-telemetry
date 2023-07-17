require_relative '../../automated_init'

context "Projection Sink" do
  context "Apply Method" do
    context "Event Data" do
      control_apply_method = Controls::Projection::ApplyMethod.example

      projection_class = Class.new do
        include Telemetry::Sink::Projection

        define_method(control_apply_method) do
        end
      end

      receiver = Controls::Projection::Receiver.example

      context "Projection Implements Apply Method for Event" do
        event = Controls::Event.example

        projection = projection_class.new(receiver)

        apply_method = projection.apply_method(event)

        comment apply_method.inspect
        detail "Method: #{control_apply_method.inspect}"

        test do
          assert(apply_method == control_apply_method)
        end
      end

      context "Projection Doesn't Implement Apply Method for Event" do
        event = Controls::Event::Other.example

        projection = projection_class.new(receiver)

        apply_method = projection.apply_method(event)

        comment apply_method.inspect

        test "No Method" do
          assert(apply_method.nil?)
        end
      end
    end
  end
end
