require_relative '../init'

require 'test_bench/isolated'; TestBenchIsolated::TestBench.activate

require 'test_bench/telemetry/controls'

include TestBench

Controls = TestBench::Telemetry::Controls rescue nil
