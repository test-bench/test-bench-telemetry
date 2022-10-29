module TestBench
  class Telemetry
    module Sink
      class Capture
        Record = Struct.new(:event, :path, :detail_level) do
          def detail_match?(match)
            if match.nil?
              true
            elsif match
              detail_level > 0
            else
              detail_level.zero?
            end
          end
          alias :detail? :detail_match?

          def detail_level_match?(detail_level)
            if detail_level.nil?
              true
            else
              detail_level == self.detail_level
            end
          end
          alias :detail_level? :detail_level_match?
        end
      end
    end
  end
end
