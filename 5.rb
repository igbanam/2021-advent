# frozen_string_literal: true

# --- Day 5: Hydrothermal Venture ---

require 'debug'

filename = $PROGRAM_NAME.gsub(/\.rb$/, '')
input = File.readlines("./#{filename}.in", chomp: true).map do |line|
  line.split(' -> ').map do |point|
    point.split(',').map(&:to_i)
  end
end

@tl_x = @tl_y = @br_x = @br_y = 0

raw_points = input.flatten(1)
@br_x = raw_points.max_by { |point| point[0] }[0]
@br_y = raw_points.max_by { |point| point[1] }[1]

arena = Array.new(@br_y - @tl_y + 1) { Array.new(@br_x - @tl_x + 1) { 0 } }

def vertical?(line)
  line[0][0] == line[1][0]
end

def horizontal?(line)
  line[0][1] == line[1][1]
end

def walk_horizontal(line)
  endpoints = line.map { |point| point[0] }
  (endpoints.min..endpoints.max).to_a.map { |x| [x, line[0][1]] }
end

def walk_vertical(line)
  endpoints = line.map { |point| point[1] }
  (endpoints.min..endpoints.max).to_a.map { |y| [line[0][0], y] }
end

def expand_range(start, finish)
  return (start..finish).to_a if start < finish

  (finish..start).to_a.reverse
end

def walk_diagonal(line)
  x_path = expand_range(line[0][0], line[1][0])
  y_path = expand_range(line[0][1], line[1][1])
  x_path.zip y_path
end

def walk(line)
  return walk_horizontal(line) if horizontal?(line)
  return walk_vertical(line) if vertical?(line)

  walk_diagonal(line)
end

def update_arena(arena, steps)
  steps.each do |step|
    arena[step[0]][step[1]] += 1
  end
end

def count_overlaps(arena)
  arena.flatten.count { |point| point > 1 }
end

input.each do |line|
  steps = walk(line)
  update_arena(arena, steps)
end

puts count_overlaps(arena)
