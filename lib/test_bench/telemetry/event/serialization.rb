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
            %r{#{self.nil}}
          end

          def self.nil
            %r{(?<nil>(?=[\n\t])?)}
          end
        end
      end
    end
  end
end
