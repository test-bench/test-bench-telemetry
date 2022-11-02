module TestBench
  class Telemetry
    module Substitute
      def self.build
        Telemetry.build
      end

      class Telemetry < Telemetry
        attr_accessor :process_id
        attr_accessor :current_time

        def sink
          @sink ||= Substitute::Sink.new
        end
        attr_writer :sink

        def self.build
          instance = new
          instance.register(instance.sink)
          instance
        end

        def events(...) = sink.events(...)
        def recorded?(...) = sink.received?(...)
      end
    end
  end
end
