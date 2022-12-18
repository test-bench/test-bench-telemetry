module TestBench
  class Telemetry
    class EventData
      module Serialization
        Error = Class.new(RuntimeError)

        def self.dump(event_data)
          type = event_data.type.to_s
          process_id = dump_value(event_data.process_id)

          text = String.new(encoding: 'BINARY')

          text << type

          text << "\t"
          text << process_id

          text << "\r\n"
          text
        end

        def self.dump_value(value)
          case value
          when Integer
            value.to_s
          end
        end

        def self.load(text)
          match_data = Pattern.match(text)
          if match_data.nil?
            raise Error, "Cannot deserialize #{text.inspect}"
          end

          type = match_data['type'].to_sym
          process_id = load_value(match_data['process_id'])

          event_data = EventData.new
          event_data.type = type
          event_data.process_id = process_id
          event_data
        end

        def self.load_value(value_text)
          match_data = Pattern.match_value(value_text)

          if match_data['integer']
            Integer(value_text)
          end
        end

        module Pattern
          def self.match(data)
            event_data.match(data)
          end

          def self.match_value(value_text)
            pattern = %r{\A#{value}\z}

            pattern.match(value_text)
          end

          def self.event_data
            %r{\A#{type}\t#{process_id}\r\n\z}
          end

          def self.type
            %r{(?<type>[A-Z][[:alnum:]]+)}
          end

          def self.process_id
            %r{(?<process_id>#{integer})}
          end

          def self.value
            %r{#{integer}}
          end

          def self.integer
            %r{(?<integer>[[:digit:]]+)}
          end
        end
      end
    end
  end
end
