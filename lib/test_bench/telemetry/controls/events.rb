module TestBench
  class Telemetry
    module Controls
      module Events
        def self.each_example(random: nil, &block)
          examples(random:).each(&block)
        end

        def self.examples(random: nil)
          random ||= false

          if random
            method_name = :random
          else
            method_name = :example
          end

          controls = TestBench::Telemetry::Event.each_event_type.map do |event_type|
            const_get(event_type)
          end

          controls.map(&method_name)
        end
      end
    end
  end
end
