# frozen_string_literal: true

# --- Day 4: Giant Squid ---

filename = $PROGRAM_NAME.gsub(/\.rb$/, '')
input = File.readlines("./#{filename}.in", chomp: true)
boards = []
@called = []
sequence = input.shift.split(',').map(&:to_i)
input.shift
input.each_slice(6) do |slice|
  boards << slice.map(&:strip).reject(&:empty?).map { |row| row.split(' ').map(&:to_i) }
end

def bingo_row?(board)
  board.any? { |row| row.all? { |num| @called.include?(num) } }
end

def bingo?(board)
  bingo_row?(board) || bingo_row?(board.transpose)
end

def play(sequence, boards)
  until sequence.empty?
    @called << sequence.shift
    boards.each do |board|
      next unless bingo?(board)

      return board
    end
  end
end

board = play(sequence, boards)

unmarked = board.flatten.uniq - @called
puts "Part 1: #{unmarked.sum * @called.last}"
