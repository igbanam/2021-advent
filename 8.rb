# frozen_string_literal: true

# --- Day 8: Seven Segment Search ---

require 'debug'

filename = $PROGRAM_NAME.gsub(/\.rb$/, '')
input = File.readlines("./#{filename}-ex.in", chomp: true)
@found = 0
DIGITS = {
  '0': 'abcefg',
  '1': 'cf',
  '2': 'acdeg',
  '3': 'acdfg',
  '4': 'bcdf',
  '5': 'abdfg',
  '6': 'abdefg',
  '7': 'acf',
  '8': 'abcdefg',
  '9': 'abcdfg'
}.freeze
LOOKING_FOR = %w[1 4 7 8].freeze
input.map do |line|
  signal, output = line.split('|').map { |feed| feed.split.map(&:chars).map(&:sort).map(&:join) }
  wanted_sizes = LOOKING_FOR.map do |digit|
    DIGITS[digit.to_sym].size
  end
  signal.keep_if { |feed| wanted_sizes.include?(feed.size) }
  output.each { |feed| @found += 1 if signal.include?(feed) }
end

puts @found
