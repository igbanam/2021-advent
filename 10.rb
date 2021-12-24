# frozen_string_literal: true

# --- Day 10: Syntax Scoring ---

require 'debug'

filename = $PROGRAM_NAME.gsub(/\.rb$/, '')
input = File.readlines("./#{filename}.in", chomp: true)
PARENTHESES = [
  ['[', ']'],
  ['(', ')'],
  ['{', '}'],
  ['<', '>'],
].flatten.freeze

# Check if the instructions in the navigation ate corrupted.
#
# Basically check if the parentheses close in a balanced manner. When a
# parenthesis closes with a brace which is not expected, the navigation is
# considered corrupted. While scanning, this should stop at the first occurence
# of corruption
def corrupted?(nav)
  to_close = []
  nav.chars.each do |brace|
    to_close << brace if opening?(brace)

    if closing?(brace)
      return true unless closing(to_close.last) == brace

      to_close.pop
    end
  end
  to_close.empty?
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

puts input.count { |instruction| corrupted?(instruction) }
