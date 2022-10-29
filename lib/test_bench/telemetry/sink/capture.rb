module TestBench
  class Telemetry
    module Sink
      class Capture
        include Sink

        def raw_records
          @raw_records ||= []
        end

        def generate_record
          @generate_record ||= Record::Generate.new
        end
        attr_writer :generate_record

        def call(event)
          record = generate_record.(event)

          raw_records.push(record)

          record
        end

        def any_record?(...)
          records(...).any?
        end
        alias :record? :any_record?

        def records(...)
          raw_records.select do |record|
            record.match?(...)
          end
        end
      end
    end
  end
end
