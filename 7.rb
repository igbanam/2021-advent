# frozen_string_literal: true

# --- Day 7: The Treachery of Whales ---

require 'debug'

filename = $PROGRAM_NAME.gsub(/\.rb$/, '')
input = File.readlines("./#{filename}.in", chomp: true)[0].split(',').map(&:to_i).sort

median = input[input.size / 2]

range = input.min..input.max
result = range.map { |point| input.map { |i| c = (i - point).abs; (c * (c + 1)) / 2 }.sum }.min

puts "Part 1: #{result}"
