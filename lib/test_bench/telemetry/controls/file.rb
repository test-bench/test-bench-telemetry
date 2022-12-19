module TestBench
  class Telemetry
    module Controls
      module File
        def self.example(...) = Temporary.example(...)

        module Random
          def random(basename: nil, extension: nil)
            suffix = Controls::Random.string

            example(suffix, basename:, extension:)
          end
        end
        extend Random

        module Name
          extend Random

          def self.example(suffix=nil, basename: nil, extension: nil)
            basename ||= self.basename
            extension ||= self.extension

            suffix = "-#{suffix}" if not suffix.nil?

            "#{basename}#{suffix}#{extension}"
          end

          def self.basename
            'some-file'
          end

          def self.extension
            '.some-ext'
          end
        end

        module Temporary
          extend Random

          def self.example(...)
            filename = Name.example(...)

            ::File.join('tmp', filename)
          end
        end
      end
    end
  end
end
