module TestBench
  class Telemetry
    module Controls
      module Result
        def self.example = pass
        def self.random = Random.boolean
        def self.pass = true
        def self.failure = false
      end
    end
  end
end
