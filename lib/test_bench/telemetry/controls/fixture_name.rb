module TestBench
  class Telemetry
    module Controls
      module FixtureName
        def self.example(suffix=nil)
          suffix = "_#{suffix}" if not suffix.nil?

          "SomeProject::Fixtures::SomeFixture#{suffix}"
        end

        def self.random
          suffix = example(Random.string)

          example(suffix)
        end
      end
    end
  end
end
