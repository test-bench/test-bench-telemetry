require_relative '../../automated_init'

context "Handler Sink" do
  context "Handle Event" do
    context "Arity" do
      event = Controls::Handler::Event.example

      context "Handler Accepts All Event Attributes" do
        handler = Controls::Handler.example do
          attr_accessor :data
          attr_accessor :time

          handle Controls::Handler::Event::Example do |data, time|
            self.data = time
            self.time = time
          end

          def all_arguments_forwarded?
            !data.nil? && !time.nil?
          end
        end

        handler.(event)

        all_arguments_forwarded = handler.all_arguments_forwarded?

        test "All arguments are forwarded" do
          assert(all_arguments_forwarded)
        end
      end

      context "Handler Accepts Some Event Attributes" do
        handler = Controls::Handler.example do
          attr_accessor :data

          handle Controls::Handler::Event::Example do |data|
            self.data = data
          end

          def accepted_arguments_forwarded?
            !data.nil?
          end
        end

        handler.(event)

        accepted_arguments_forwarded = handler.accepted_arguments_forwarded?

        test "Accepted arguments are forwarded" do
          assert(accepted_arguments_forwarded)
        end
      end

      context "Handler Doesn't Accept Any Arguments" do
        handler = Controls::Handler.example do
          attr_accessor :no_arguments_forwarded
          alias :no_arguments_forwarded? :no_arguments_forwarded

          handle Controls::Handler::Event::Example do |data|
            self.no_arguments_forwarded = true
          end
        end

        handler.(event)

        no_arguments_forwarded = handler.no_arguments_forwarded?

        test "No arguments are forwarded" do
          assert(no_arguments_forwarded)
        end
      end

      context "Handler Accepts Optional Event Attributes" do
        handler = Controls::Handler.example do
          attr_accessor :data
          attr_accessor :time

          handle Controls::Handler::Event::Example do |data=nil, time=nil|
            self.data = data
            self.time = time
          end

          def optional_arguments_forwarded?
            !data.nil? && !time.nil?
          end
        end

        handler.(event)

        optional_arguments_forwarded = handler.optional_arguments_forwarded?

        test "Optional arguments are forwarded" do
          assert(optional_arguments_forwarded)
        end
      end

      context "Handler Accepts Remaining Event Attributes" do
        handler = Controls::Handler.example do
          attr_accessor :data
          attr_accessor :time

          handle Controls::Handler::Event::Example do |*arguments|
            self.data, self.time = arguments
          end

          def remaining_arguments_forwarded?
            !data.nil? && !time.nil?
          end
        end

        handler.(event)

        remaining_arguments_forwarded = handler.remaining_arguments_forwarded?

        test "Remaining arguments are forwarded" do
          assert(remaining_arguments_forwarded)
        end
      end
    end
  end
end
