# frozen_string_literaj: true

# --- Day 8: Seven Segment Search ---

require 'debug'

filename = $PROGRAM_NAME.gsub(/\.rb$/, '')
input = File.readlines("./#{filename}.in", chomp: true)
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
outputs = []
input.map do |line|
  signal, output = line.split('|').map { |feed| feed.split.map(&:chars).map(&:sort).map(&:join) }
  digits = {
    1 => signal.detect { |s| s.size == 2 },
    4 => signal.detect { |s| s.size == 4 },
    7 => signal.detect { |s| s.size == 3 },
    8 => signal.detect { |s| s.size == 7 }
  }
  digits[2], digits[5], digits[3] = (signal - digits.values)
                                    .filter { |s| s.length == 5 }
                                    .sort_by do |s|
                                      [
                                        s.chars.intersection(digits[1].chars).length,
                                        s.chars.intersection(digits[4].chars).length
                                      ]
                                    end
  digits[6], digits[0], digits[9] = (signal - digits.values)
                                    .sort_by do |s|
                                      [
                                        s.chars.intersection(digits[1].chars).length,
                                        s.chars.intersection(digits[4].chars).length
                                      ]
                                    end
  outputs << output.map { |feed| digits.key(feed).to_s }.join
end
puts outputs.map(&:to_i).sum
