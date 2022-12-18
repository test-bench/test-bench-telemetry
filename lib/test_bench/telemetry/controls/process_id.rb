module TestBench
  class Telemetry
    module Controls
      module ProcessID
        def self.example = 11111
        def self.other_example = 22222
        def self.random = Random.integer
      end
    end
  end
end
