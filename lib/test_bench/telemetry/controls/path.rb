module TestBench
  class Telemetry
    module Controls
      module Path
        def self.example(suffix=nil)
          suffix = "_#{suffix}" if not suffix.nil?

          "path/to/some_file#{suffix}.rb"
        end

        module Random
          def random = example(Controls::Random.string)
        end
        extend Random

        module Temporary
          def self.example(suffix=nil, basename: nil, extension: nil)
            basename ||= self.basename
            extension ||= self.extension

            suffix = "-#{suffix}" if not suffix.nil?

            filename = "#{basename}#{suffix}#{extension}"

            File.join('tmp', filename)
          end

          def self.random(basename: nil, extension: nil)
            suffix = Controls::Random.string

            example(suffix, basename:, extension:)
          end

          def self.basename
            'some-file'
          end

          def self.extension
            '.some-ext'
          end
        end

        module Absolute
          extend Random

          def self.example(suffix=nil)
            path = Path.example(suffix)

            File.join('/', path)
          end

          module Local
            extend Random

            def self.example(suffix=nil)
              path = Path.example(suffix)

              File.join(current_dir, path)
            end

            def self.current_dir
              File.join('/home', 'some-user', 'some-working-dir')
            end

            module Gem
              extend Random

              def self.example(path=nil)
                path ||= Path.example

                path = File.join(gems_path, path)

                Local.example(path)
              end

              def self.gems_path
                ruby_version = RbConfig::CONFIG['ruby_version']

                "gems/ruby/#{ruby_version}/gems"
              end
            end
          end
        end
      end
    end
  end
end
