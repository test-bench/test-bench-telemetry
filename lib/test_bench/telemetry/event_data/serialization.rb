module TestBench
  class Telemetry
    class EventData
      module Serialization
        Error = Class.new(RuntimeError)

        def self.dump(event_data)
          type = event_data.type.to_s

          text = String.new(encoding: 'BINARY')

          text << type

          text << "\r\n"
          text
        end

        def self.load(text)
          match_data = Pattern.match(text)
          if match_data.nil?
            raise Error, "Cannot deserialize #{text.inspect}"
          end

          type = match_data['type'].to_sym

          event_data = EventData.new
          event_data.type = type
          event_data
        end

        module Pattern
          def self.match(data)
            event_data.match(data)
          end

          def self.event_data
            %r{\A#{type}\r\n\z}
          end

          def self.type
            %r{(?<type>[A-Z][[:alnum:]]+)}
          end
        end
      end
    end
  end
end
