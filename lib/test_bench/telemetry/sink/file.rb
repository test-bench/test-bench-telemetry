module TestBench
  class Telemetry
    module Sink
      class File
        include Sink

        attr_reader :io

        def initialize(io)
          @io = io
        end

        def self.open(path, &block)
          ::File.open(path, 'w') do |io|
            instance = new(io)

            block.(instance, io)

            return instance
          end
        end

        def call(event)
          data = event.dump

          io.write(data)
        end
      end
    end
  end
end
