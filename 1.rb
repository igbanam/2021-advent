# frozen_string_literal: true

# Day 1: Sonar Sweep

filename = $0.gsub(".rb", "")
depthmap = File.readlines("./#{filename}.in", chomp: true).map!(&:to_i)
increments = 0
depthmap.each_cons(2) { |p, n| increments += 1 if p < n }
puts increments
