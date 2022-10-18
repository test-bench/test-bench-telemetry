module TestBench
  class Telemetry
    module Controls
      module DetailLevel
        def self.example
          1
        end

        def self.random
          Random.integer % 11
        end
      end
    end
  end
end
