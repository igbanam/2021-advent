# frozen_string_literal: true

# --- Day 2: Dive! ---

filename = $PROGRAM_NAME.gsub('.rb', '')
horizontal = 0
depth = 0
aim = 0

instructions = File.readlines("./#{filename}.in", chomp: true)
instructions.map(&:split).each do |direction, distance|
  distance = distance.to_i
  case direction
  when 'down'
    aim += distance
  when 'up'
    aim -= distance
  when 'forward'
    horizontal += distance
    depth += aim * distance
  end
end

puts horizontal * depth
