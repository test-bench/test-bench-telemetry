module TestBench
  class Telemetry
    module Controls
      module Time
        def self.example(offset_milliseconds: nil, offset_nanoseconds: nil)
          if offset_nanoseconds.nil?
            offset_milliseconds ||= 0
            offset_nanoseconds = offset_milliseconds * 1_000_000
          end

          nanoseconds = 111_111_111
          remaining_offset, additional_nanoseconds = offset_nanoseconds.divmod(1_000_000_000 - nanoseconds)
          nanoseconds += additional_nanoseconds
          microseconds = Rational(nanoseconds, 1_000)

          if remaining_offset.zero?
            seconds = 11
          else
            remaining_offset, seconds = remaining_offset.divmod(60)
          end

          if remaining_offset.zero?
            minutes = 11
          else
            remaining_offset, minutes = remaining_offset.divmod(60)
          end

          if remaining_offset.zero?
            hours = 11
          else
            remaining_offset, hours = remaining_offset.divmod(24)
          end

          if remaining_offset.zero?
            day = 1
          else
            remaining_offset, day = remaining_offset.divmod(28)
            day += 1
          end

          if remaining_offset.zero?
            month = 1
          else
            remaining_offset, month = remaining_offset.divmod(12)
            month += 1
          end

          year = 2000
          if not remaining_offset.zero?
            year += remaining_offset
          end

          ::Time.utc(year, month, day, hours, minutes, seconds, microseconds)
        end

        def self.random
          example(offset_nanoseconds: Random.integer)
        end

        module ISO8601
          def self.example(time=nil, **arguments)
            time ||= Time.example(**arguments)

            time.strftime('%Y-%m-%dT%H:%M:%S.%NZ')
          end

          def self.random(...)
            time = Time.random

            example(time)
          end
        end
      end
    end
  end
end
