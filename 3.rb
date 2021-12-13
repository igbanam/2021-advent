# frozen_string_literal: true

# --- Day 3: Binary Diagnostic ---

require 'debug'

filename = $PROGRAM_NAME.gsub('.rb', '')
input = File.readlines("./#{filename}.in", chomp: true)
input.map!(&:chars)
gamma_rate = []
epsilon_rate = []

(0..input.first.size).each do |i|
  col = input.map { |row| row[i] }
  col_tally = col.tally.to_h
  gamma_rate << col_tally.max_by { |_k, v| v }.first
  epsilon_rate << col_tally.min_by { |_k, v| v }.first
end

gamma = gamma_rate.join.to_i(2)
epsilon = epsilon_rate.join.to_i(2)

puts gamma * epsilon
