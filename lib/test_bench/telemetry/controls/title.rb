module TestBench
  class Telemetry
    module Controls
      module Title
        def self.example(suffix=nil, text: nil)
          suffix = " #{suffix}" if not suffix.nil?
          text ||= self.text

          "#{text}#{suffix}"
        end

        def self.text = "Some Title"

        module Random
          def random = example(Controls::Random.string)
        end
        extend Random

        module Test
          extend Random

          def self.example(suffix=nil)
            Title.example(suffix, text: example_text)
          end
          def self.example_text = "Some test"

          def self.other_example = "Some other test"
        end

        module Context
          extend Random

          def self.example(suffix=nil)
            Title.example(suffix, text: example_text)
          end
          def self.example_text = "Some Context"

          def self.other_example = "Some Other Context"
        end
      end
    end
  end
end
