require_relative '../../automated_init'

context "Telemetry" do
  context "Configure Receiver" do
    attr_name = :telemetry
    comment "Default Attribute Name: #{attr_name.inspect}"

    receiver = Struct.new(attr_name).new

    Telemetry.configure(receiver)

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
