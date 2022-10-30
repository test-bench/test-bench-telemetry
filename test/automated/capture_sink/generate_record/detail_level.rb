require_relative '../../automated_init'

context "Capture Sink" do
  context "Generate Record" do
    context "Detail Level" do
      untested_event_types = Telemetry::Event.each_event_type.to_a

      control_detail_level = Controls::DetailLevel.example

      context "Affects Detail Level" do
        [
          [Controls::Events::DetailIncreased.example, 1],
          [Controls::Events::DetailDecreased.example, -1]
        ].each do |(event, detail_level_change)|
          event_type = event.event_type

          untested_event_types.delete(event_type)

          context "#{event_type}" do
            generate_record = Telemetry::Sink::Capture::Record::Generate.new

            generate_record.detail_level = control_detail_level

            record = generate_record.(event)

            context "Record's Detail Level" do
              detail_level = record.detail_level

              comment detail_level.inspect
              detail "Previous Detail Level: #{control_detail_level.inspect}"

              affected = detail_level == control_detail_level + detail_level_change

              test "Affected" do
                assert(affected)
              end
            end

            context "Next Record's Detail Level" do
              next_detail_level = generate_record.detail_level

              comment next_detail_level.inspect
              detail "Previous Detail Level: #{control_detail_level.inspect}"

              updated = next_detail_level == control_detail_level + detail_level_change

              test "Updated" do
                assert(updated)
              end
            end
          end
        end
      end

      context "Doesn't Affect Detail Level" do
        Controls::Events.each_example do |event|
          event_type = event.event_type
          if not untested_event_types.include?(event_type)
            next
          end

          context "#{event_type}" do
            generate_record = Telemetry::Sink::Capture::Record::Generate.new

            generate_record.detail_level = control_detail_level

            record = generate_record.(event)

            context "Record's Detail Level" do
              detail_level = record.detail_level

              comment detail_level.inspect
              detail "Original Detail Level: #{control_detail_level.inspect}"

              not_affected = detail_level == control_detail_level

              test "Not affected" do
                assert(not_affected)
              end
            end

            context "Next Record's Detail Level" do
              next_detail_level = generate_record.detail_level

              comment next_detail_level.inspect
              detail "Original Detail Level: #{control_detail_level.inspect}"

              not_updated = next_detail_level == control_detail_level

              test "Not updated" do
                assert(not_updated)
              end
            end
          end
        end
      end
    end
  end
end
