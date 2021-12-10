# frozen_string_literal: true

# --- Day 9: Smoke Basin ---

filename = "9-ex1"
# filename = $0.gsub(".rb", "")
@heightmap = File.readlines("./#{filename}.in", chomp: true)
@heightmap.map! do |row|
  row.chars.map!(&:to_i)
end.freeze

low_points = []
out = Array.new(@heightmap.size)  { Array.new(@heightmap.first.size) { '.' } }

def low_point?(i, j)
  location = @heightmap[i][j]
  top = i - 1 >= 0 ? @heightmap[i - 1][j] : nil
  bottom = i + 1 < @heightmap.size ? @heightmap[i + 1][j] : nil
  left = j - 1 >= 0 ? @heightmap[i][j - 1] : nil
  right = j + 1 < @heightmap.first.size ? @heightmap[i][j + 1] : nil
  neighbors = [top, bottom, left, right].compact
  location < neighbors.min
end

(0...@heightmap.size).each do |i|
  (0...@heightmap.first.size).each do |j|
    if low_point?(i, j)
      low_points << @heightmap[i][j]
      out[i][j] = @heightmap[i][j].to_s
    end
  end
end

File.write("#{filename}.out", out.map(&:join).join("\n"))

puts low_points.map { |l| l + 1 }.sum
