require_relative '../../automated_init'

context "Capture Sink" do
  context "Path" do
    context "Copy Predicate" do
      control_path = Controls::CaptureSink::Path.example

      context "Same Segments" do
        context "Different Instances" do
          segments = control_path.segments
          path = Controls::CaptureSink::Path.example(segments)

          copied = path.copy?(control_path)

          test "Copied" do
            assert(copied)
          end
        end

        context "Same Instances" do
          path = control_path

          copied = path.copy?(control_path)

          test "Not copied" do
            refute(copied)
          end
        end
      end

      context "Different Segments" do
        segments = [*control_path.segments, Controls::Random.string]
        path = Controls::CaptureSink::Path.example(segments)

        copied = path.copy?(control_path)

        test "Not copied" do
          refute(copied)
        end
      end
    end
  end
end
