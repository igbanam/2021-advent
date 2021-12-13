# frozen_string_literal: true

# --- Day 3: Binary Diagnostic ---

require 'debug'

def max_first(array)
  return '1' if array.size == 2 && array[0] != array[1]

  array.tally.to_h.max_by { |_k, v| v }.first
end

def min_first(array)
  return '0' if array.size == 2 && array[0] != array[1]

  array.tally.to_h.min_by { |_k, v| v }.first
end

mins = -> (array) { min_first(array) }
maxs = -> (array) { max_first(array) }

def rating(array, selector)
  (0...array.first.size).each do |i|
    col = array.map { |row| row[i] }
    array.keep_if { |datum| datum[i] == selector.call(col) }
    break if array.size == 1
  end
  array.join.to_i(2)
end

filename = $PROGRAM_NAME.gsub('.rb', '')
input = File.readlines("./#{filename}-ex1.in", chomp: true).map!(&:chars)

oxygen_collector = input.map(&:dup)
co2_collector = input.map(&:dup)

oxygen = rating(oxygen_collector, maxs)
co2 = rating(co2_collector, mins)

puts oxygen * co2
