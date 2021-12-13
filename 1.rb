# frozen_string_literal: true

# Day 1: Sonar Sweep

# Sum every three inputs in array
def sum_three(input)
  input.each_cons(3).map { |a, b, c| a + b + c }
end

def sonar_sweep(input)
  increments = 0
  input.each_cons(2) { |p, n| increments += 1 if p < n }
  increments
end

filename = $PROGRAM_NAME.gsub('.rb', '')
depthmap = File.readlines("./#{filename}.in", chomp: true).map!(&:to_i)
puts sonar_sweep(sum_three(depthmap))
