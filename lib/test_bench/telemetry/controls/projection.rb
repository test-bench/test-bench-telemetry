module TestBench
  class Telemetry
    module Controls
      module Projection
        def self.example(receiver=nil)
          receiver ||= Receiver.example

          Example.new(receiver)
        end

        class Example
          include Telemetry::Sink::Projection

          receiver_name :some_receiver
        end
      end
    end
  end
end
