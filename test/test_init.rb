ENV['BOOTSTRAP'] ||= 'on'

require_relative '../init'

if ENV['BOOTSTRAP'] == 'on'
  require 'test_bench/bootstrap'; TestBench::Bootstrap.activate
else
  require 'test_bench'; TestBench.activate
end

require 'test_bench/telemetry/controls'

include TestBench

Controls = TestBench::Telemetry::Controls rescue nil
