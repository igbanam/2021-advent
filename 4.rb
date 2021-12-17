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
  completed_boards = []
  until sequence.empty?
    break if completed_boards.size == boards.size

    @called << sequence.shift
    boards.each_with_index do |board, i|
      next if completed_boards.include?(i)
      next unless bingo?(board)

      completed_boards << i
    end
  end
  boards[completed_boards.last]
end

board = play(sequence, boards)

unmarked = board.flatten.delete_if { |num| @called.include?(num) }
puts "Answer: #{unmarked.sum * @called.last}"
