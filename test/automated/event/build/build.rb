require_relative '../../automated_init'

context "Event" do
  context "Build" do
    control_some_attribute = Controls::Event.some_attribute
    control_some_other_attribute = Controls::Event.some_other_attribute
    control_process_id = Controls::Event.process_id
    control_time = Controls::Event.time

    event = Controls::Event::SomeEvent.build(
      control_some_attribute,
      control_some_other_attribute,
      process_id: control_process_id,
      time: control_time
    )

    test! do
      assert(event.instance_of?(Controls::Event::SomeEvent))
    end

    context "Attributes" do
      context "some_attribute" do
        some_attribute = event.some_attribute

        comment some_attribute.inspect
        detail "Control: #{control_some_attribute.inspect}"

        test do
          assert(some_attribute == control_some_attribute)
        end
      end

      context "some_other_attribute" do
        some_other_attribute = event.some_other_attribute

        comment some_other_attribute.inspect
        detail "Control: #{control_some_other_attribute.inspect}"

        test do
          assert(some_other_attribute == control_some_other_attribute)
        end
      end
    end

    context "Metadata" do
      metadata = event.metadata

      context "Process ID" do
        process_id = metadata.process_id

        comment process_id.inspect
        detail "Control: #{control_process_id.inspect}"

        test do
          assert(process_id == control_process_id)
        end
      end

      context "Time" do
        time = metadata.time

        comment time.inspect
        detail "Control: #{control_time.inspect}"

        test do
          assert(time == control_time)
        end
      end
    end
  end
end
