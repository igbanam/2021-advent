# frozen_string_literal: true

# --- Day 10: Syntax Scoring ---

require 'debug'

filename = $PROGRAM_NAME.gsub(/\.rb$/, '')
input = File.readlines("./#{filename}.in", chomp: true)

PARENTHESES = [
  ['[', ']'],
  ['(', ')'],
  ['{', '}'],
  ['<', '>']
].flatten.freeze

THE_LAW = {
  ')': 3,
  ']': 57,
  '}': 1_197,
  '>': 25_137
}.freeze

# Check if the instructions in the navigation ate corrupted.
#
# Basically check if the parentheses close in a balanced manner. When a
# parenthesis closes with a brace which is not expected, the navigation is
# considered corrupted. While scanning, this should stop at the first occurence
# of corruption
def corruption(nav)
  to_close = []
  nav.chars.each do |brace|
    to_close << brace if opening?(brace)

    if closing?(brace)
      return brace unless closing(to_close.last) == brace

      to_close.pop
    end
  end
  to_close
end

def cost(corruption)
  THE_LAW[corruption.to_sym]
end

def active(brace)
  PARENTHESES.index(brace) / 2
end

def opening?(brace)
  PARENTHESES.index(brace).even?
end

def closing?(brace)
  PARENTHESES.index(brace).odd?
end

def opening(brace)
  raise "I'm confused; #{brace} should be a closing brace." unless closing?(brace)

  PARENTHESES[PARENTHESES.index(brace) - 1]
end

def closing(brace)
  raise "I'm confused; #{brace} should be an opening brace." unless opening?(brace)

  PARENTHESES[PARENTHESES.index(brace) + 1]
end

def autocomplete(closeable)
  closeable.reverse.map { |brace| closing(brace) }
end

def score(completion)
  closers = THE_LAW.keys.map(&:to_s)
  completion.chars.reduce(0) do |total, char|
    (total * 5) + closers.index(char) + 1
  end
end

corruptibles = input.map { |instruction| corruption(instruction) }
corruptibles.reject { |c| c.is_a?(Array) }.map { |f| cost(f) }.tap do |costs|
  puts "The navigation is corrupted. The cost of the repair is #{costs.sum}"
end

incomplete = corruptibles.select { |c| c.is_a?(Array) }
incomplete.map { |c| score(autocomplete(c).join) }.sort.tap do |scores|
  puts "Winning autocorrect is #{scores[scores.size / 2]}"
end
