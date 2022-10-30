require_relative '../../automated_init'

context "Capture Sink" do
  context "Record" do
    context "Detail Match Predicate" do
      context "Record's Detail Level Is Greater Than Zero" do
        [1, 11].each do |detail_level|
          context "Detail Level: #{detail_level}" do
            record = Controls::CaptureSink::Record.example(detail_level:)

            context "True" do
              matches = record.detail_match?(true)

              test "Matches" do
                assert(matches)
              end
            end

            context "False" do
              matches = record.detail_match?(false)

              test "Doesn't match" do
                refute(matches)
              end
            end

            context "Nil" do
              matches = record.detail_match?(nil)

              test "Matches" do
                assert(matches)
              end
            end
          end
        end
      end

      context "Record's Detail Level Is Zero" do
        record = Controls::CaptureSink::Record.example(detail_level: 0)

        context "False" do
          matches = record.detail_match?(false)

          test "Matches" do
            assert(matches)
          end
        end

        context "True" do
          matches = record.detail_match?(true)

          test "Doesn't match" do
            refute(matches)
          end
        end

        context "Nil" do
          matches = record.detail_match?(nil)

          test "Matches" do
            assert(matches)
          end
        end
      end
    end
  end
end
