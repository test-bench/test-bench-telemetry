module TestBench
  class Telemetry
    module Sink
      class Capture
        class Record
          class Generate
            include Event::Events

            def path
              @path ||= Path.new
            end
            attr_writer :path

            def detail_level
              @detail_level ||= 0
            end
            attr_writer :detail_level

            def call(event)
              case event
              when TestStarted, ContextEntered
                path.push(event.title)
              when TestFinished, ContextExited
                path.pop(event.title)
              when DetailIncreased
                self.detail_level += 1
              when DetailDecreased
                self.detail_level -= 1
              end

              record = Record.build(event, path, detail_level)

              case event
              when TestFinished, ContextExited
                title = event.title
                record.path.push(title)
              when Commented
                comment = event.comment
                record.path.push(comment)
              end

              record
            end
          end
        end
      end
    end
  end
end
