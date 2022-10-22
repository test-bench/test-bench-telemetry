module TestBench
  class Telemetry
    module Sink
      class File
        include Sink

        attr_reader :io

        def initialize(io)
          @io = io
        end

        def call(event)
          data = event.dump

          io.write(data)
        end
      end
    end
  end
end
