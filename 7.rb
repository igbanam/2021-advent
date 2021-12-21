# frozen_string_literal: true

# --- Day 7: The Treachery of Whales ---

require 'debug'

filename = $PROGRAM_NAME.gsub(/\.rb$/, '')
input = File.readlines("./#{filename}.in", chomp: true)[0].split(',').map(&:to_i).sort

median = input[input.size / 2]

result = input.map { |i| (i - median).abs }.sum

puts "Part 1: #{result}"
