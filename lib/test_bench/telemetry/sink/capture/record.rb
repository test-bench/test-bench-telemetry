module TestBench
  class Telemetry
    module Sink
      class Capture
        Record = Struct.new(:event, :path, :detail_level) do
          def self.build(event, path, detail_level)
            instance = new
            instance.event = event
            instance.detail_level = detail_level

            path.copy(instance)

            instance
          end

          def match?(*path_segments, detail: nil, detail_level: nil, &block)
            if not path_segments?(*path_segments)
              false
            elsif not detail?(detail)
              false
            elsif not detail_level?(detail_level)
              false
            elsif not block?(&block)
              false
            else
              true
            end
          end

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

          def path_segments_match?(*segments)
            if segments.empty?
              true
            else
              path.match?(*segments)
            end
          end
          alias :path_segments? :path_segments_match?

          def block_match?(&block)
            if block.nil?
              true
            elsif block.(event.event_type, *event.values)
              true
            else
              false
            end
          end
          alias :block? :block_match?
        end
      end
    end
  end
end
