module TestBench
  class Telemetry
    module Sink
      class File
        include Sink

        attr_reader :io

        def initialize(io)
          @io = io
        end

        def receive(event_data)
          text = event_data.dump

          io.write(text)
        end
      end
    end
  end
end
