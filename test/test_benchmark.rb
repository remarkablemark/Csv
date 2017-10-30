require 'minitest/autorun'
require 'minitest/benchmark'
require_relative '../csv'

class BenchCsv < MiniTest::Benchmark
  def bench_csv_parse
    assert_performance_linear 0.99 do |n|
      Csv.parse("a,b,c\nd,e,f\n\"g\",\"h,\",\"i\n\"\n\n,,,\n" * n)
    end
  end
end
