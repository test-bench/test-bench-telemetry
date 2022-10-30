module TestBench
  class Telemetry
    module Sink
      class Capture
        include Sink

        MatchError = Class.new(RuntimeError)

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

        def one_record?(...)
          record = one_record(...)

          !record.nil?
        end

        def one_record(...)
          records = records(...)

          if records.count > 1
            raise MatchError, "More than one record matches (Matching Records: #{records.count})"
          end

          records.first
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
