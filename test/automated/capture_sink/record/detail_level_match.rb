require_relative '../../automated_init'

context "Capture Sink" do
  context "Record" do
    context "Detail Level Match Predicate" do
      detail_level = Controls::DetailLevel.example

      context "Record's Detail Level Is Equal" do
        record_detail_level = detail_level

        record = Controls::CaptureSink::Record.example(detail_level: record_detail_level)

        matches = record.detail_level?(detail_level)

        test "Matches" do
          assert(matches)
        end
      end

      context "Record's Detail Level Is Greater" do
        record_detail_level = detail_level + 1

        record = Controls::CaptureSink::Record.example(detail_level: record_detail_level)

        matches = record.detail_level?(detail_level)

        test "Doesn't match" do
          refute(matches)
        end
      end

      context "Record's Detail Level Is Less" do
        record_detail_level = detail_level - 1

        record = Controls::CaptureSink::Record.example(detail_level: record_detail_level)

        matches = record.detail_level?(detail_level)

        test "Doesn't match" do
          refute(matches)
        end
      end

      context "Nil" do
        record = Controls::CaptureSink::Record.example(detail_level:)

        matches = record.detail_level?(detail_level)

        test "Matches" do
          assert(matches)
        end
      end
    end
  end
end
