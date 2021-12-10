# frozen_string_literal: true

# --- Day 9: Smoke Basin ---

@heightmap = File.readlines('./9.in', chomp: true)
@heightmap.map! do |row|
  row.chars.map!(&:to_i)
end.freeze

low_points = []
out = []

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
  out_row = []
  (0...@heightmap.first.size).each do |j|
    if low_point?(i, j)
      low_points << @heightmap[i][j]
      out_row << @heightmap[i][j].to_s
    else
      out_row << '.'
    end
  end
  out << out_row.join + "\n"
end

File.write('9.out', out.join)

puts low_points.map { |l| l + 1 }.sum
