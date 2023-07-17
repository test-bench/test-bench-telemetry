module TestBench
  class Telemetry
    module Sink
      module Projection
        def self.included(cls)
          cls.class_exec do
            extend ReceiverNameMacro
          end
        end

        attr_accessor :receiver

        def initialize(receiver)
          @receiver = receiver
        end

        module ReceiverNameMacro
          def receiver_name_macro(receiver_name)
            define_method(receiver_name) do
              receiver
            end
          end
          alias :receiver_name :receiver_name_macro
        end
      end
    end
  end
end
