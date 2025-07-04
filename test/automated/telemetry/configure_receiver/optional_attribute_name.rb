require_relative '../../automated_init'

context "Telemetry" do
  context "Configure Receiver" do
    context "Optional Attribute Name Given" do
      attr_name = :some_other_attr
      comment "Attribute Name: #{attr_name.inspect}"

      receiver = Struct.new(attr_name).new

      Telemetry.configure(receiver, attr_name:)

      telemetry = receiver.public_send(attr_name)

      context "Configured" do
        comment telemetry.class.name

        configured = telemetry.instance_of?(Telemetry)

        test do
          assert(configured)
        end
      end
    end
  end
end
