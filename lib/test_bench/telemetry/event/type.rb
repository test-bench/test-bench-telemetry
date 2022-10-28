module TestBench
  class Telemetry
    module Event
      module Type
        def self.get(class_name)
          *, constant_name = class_name.split('::')

          constant_name.to_sym
        end

        def self.method_cased(event_type)
          pascal_cased = event_type.to_s

          underscore_cased = pascal_cased.gsub(%r{(?:\A|[a-z])[A-Z]+}) do |match_text|
            if ('a'..'z').include?(match_text[0])
              match_text.insert(1, '_')
            end
            match_text.downcase!
            match_text
          end

          underscore_cased.to_sym
        end
      end
    end
  end
end
