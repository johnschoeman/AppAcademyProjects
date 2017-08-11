#!/usr/bin/env ruby
require 'io/console'
require 'benchmark'
require_relative 'octopus'

class OctopusSortBenchmark

  def self.run_sluggish_sort(arrays)
    arrays.each do |array|
      array_to_test = array.dup
      sluggish_octopus(array_to_test)
    end
  end

  def self.run_dominant_sort(arrays)
    arrays.each do |array|
      array_to_test = array.dup
      dominant_octopus(array_to_test)
    end
  end

  def self.run_clever(arrays)
    arrays.each do |array|
      array_to_test = array.dup
      clever_octopus(array_to_test)
    end
  end

  def self.performance_test(size, count)
    arrays_to_test = Array.new(count) { random_arr(size) }

    Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
                        "Avg. Slugg:  ", "Avg. Dominant: ", "Avg. Clever") do |b|
      sluggish = b.report("Tot. Slugg:  ") { run_sluggish_sort(arrays_to_test) }
      dominant = b.report("Tot. Dominant: ") { run_dominant_sort(arrays_to_test) }
      clever = b.report("Tot. Clever: ") { run_clever(arrays_to_test)}
      [sluggish/count, dominant/count, clever/count]
    end
  end

  def self.random_arr(n)
    Array.new(n) { rand(n) }
  end

  def self.run_performance_tests(multiplier = 5, rounds = 3)
    [1, 10, 100, 1000, 10000].each do |size|
      size *= multiplier
      wait_for_keypress(
        "Press any key to benchmark sorts for #{size} elements"
      )
      performance_test(size, rounds)
    end
  end

  def self.wait_for_keypress(prompt)
    puts prompt
    STDIN.getch
  end
end

OctopusSortBenchmark.run_performance_tests()
