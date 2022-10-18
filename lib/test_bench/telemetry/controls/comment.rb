module TestBench
  class Telemetry
    module Controls
      module Comment
        def self.example(suffix=nil)
          suffix = " #{suffix}" if not suffix.nil?

          "Some comment#{suffix}"
        end

        def self.random
          suffix = Random.string

          example(suffix)
        end
      end
    end
  end
end
