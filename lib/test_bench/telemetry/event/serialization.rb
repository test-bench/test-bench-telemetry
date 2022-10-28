module TestBench
  class Telemetry
    module Event
      module Serialization
        Error = Class.new(RuntimeError)

        def self.dump(event)
          event_type = event.event_type.to_s

          data = String.new(encoding: 'BINARY')

          data << event_type

          event.values.each do |value|
            data << "\t"
            data << dump_value(value)
          end

          data << "\r\n"
          data
        end

        def self.dump_value(value)
          case value
          when NilClass
            ''
          when Time
            value.strftime('%Y-%m-%dT%H:%M:%S.%NZ')
          when String
            value.dump
          when Integer
            value.to_s
          end
        end

        def self.load(data, event_namespace)
          match_data = Pattern.match(data)
          if match_data.nil?
            raise Error, "Cannot deserialize #{data.inspect}"
          end

          event_type = match_data['event_type'].to_sym
          if not event_namespace.const_defined?(event_type, false)
            raise Error, "Unknown event type #{event_type.inspect}"
          end

          values = match_data['values'].split("\t").map do |value_data|
            load_value(value_data)
          end

          event_class = event_namespace.const_get(event_type, false)
          event_class.new(*values)
        end

        def self.load_value(value_data)
          match_data = Pattern.match_value(value_data)

          if match_data['nil']
            nil
          elsif match_data['time']
            year = match_data['year'].to_i
            month = match_data['month'].to_i
            day = match_data['day'].to_i
            hour = match_data['hour'].to_i
            minute = match_data['minute'].to_i
            second = match_data['second'].to_i

            nanosecond = match_data['nanosecond'].to_i
            usec = Rational(nanosecond, 1_000)

            Time.utc(year, month, day, hour, minute, second, usec)
          elsif match_data['string']
            value_data.undump
          elsif match_data['integer']
            Integer(value_data)
          end
        end

        module Pattern
          def self.match(data)
            event.match(data)
          end

          def self.match_value(value_data)
            pattern = %r{\A#{value}\z}

            pattern.match(value_data)
          end

          def self.event
            %r{\A#{event_type}\t#{values}\r\n\z}
          end

          def self.event_type
            %r{(?<event_type>[A-Z][[:alpha:]]+)}
          end

          def self.values
            %r{(?<values>#{value}(?:\t#{value})*)}
          end

          def self.value
            %r{#{self.nil}|#{time}|#{string}|#{integer}}
          end

          def self.nil
            %r{(?<nil>(?=[\n\t])?)}
          end

          def self.time
            year = %r{(?<year>[[:digit:]]{4})}
            month = %r{(?<month>[[:digit:]]{2})}
            day = %r{(?<day>[[:digit:]]{2})}
            hour = %r{(?<hour>[[:digit:]]{2})}
            minute = %r{(?<minute>[[:digit:]]{2})}
            second = %r{(?<second>[[:digit:]]{2})}
            nanosecond = %r{(?<nanosecond>[[:digit:]]{9})}

            %r{(?<time>#{year}-#{month}-#{day}T#{hour}:#{minute}:#{second}\.#{nanosecond}Z)}
          end

          def self.string
            %r{(?<string>".*")}
          end

          def self.integer
            %r{(?<integer>[[:digit:]]+)}
          end
        end
      end
    end
  end
end
