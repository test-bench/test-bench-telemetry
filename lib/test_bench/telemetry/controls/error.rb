module TestBench
  class Telemetry
    module Controls
      module Error
        module Text
          def self.example(message: nil, label: nil, path: nil, line_number: nil, exception_class: nil)
            message ||= self.message
            label ||= self.label
            path ||= self.path
            line_number ||= self.line_number
            exception_class ||= self.exception_class

            "#{path}:#{line_number}:in `#{label}': \e[1m#{message} (\e[4m#{exception_class}\e[24m)\e[m"
          end

          def self.random
            message = "#{self.message} #{Random.string}"
            label = "#{self.label}_#{Random.string}"
            path = Path::Absolute::Local.random
            line_number = LineNumber.random

            example(message:, label:, path:, line_number:)
          end

          def self.message = "Some error message"
          def self.label = 'some_method'
          def self.path = Path::Absolute::Local.example
          def self.line_number = LineNumber.example
          def self.exception_class = Example
        end

        Example = Class.new(RuntimeError)
      end
    end
  end
end
