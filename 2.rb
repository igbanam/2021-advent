# frozen_string_literal: true

# --- Day 2: Dive! ---

filename = $PROGRAM_NAME.gsub('.rb', '')
horizontal = 0
depth = 0

instructions = File.readlines("./#{filename}.in", chomp: true)
instructions.map(&:split).each do |direction, distance|
  distance = distance.to_i
  case direction
  when 'down'
    depth += distance
  when 'up'
    depth -= distance
  when 'forward'
    horizontal += distance
  end
end

puts horizontal * depth
