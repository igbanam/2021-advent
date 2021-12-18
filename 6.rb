# frozen_string_literal: true

# --- Day 6: LanternFish ---

require 'debug'

filename = $PROGRAM_NAME.gsub(/\.rb$/, '')
input = File.readlines("./#{filename}.in", chomp: true)[0].split(',').map(&:to_i)

# Simulate reproduction of LanternFish through days
class Simulator
  FINAL_DAY = 80

  def initialize(input)
    @day = 0
    @fishes = input
  end

  class << self
    def simulate(input)
      new(input).simulate
    end
  end

  def simulate
    loop do
      @day += 1
      live
      break if @day == FINAL_DAY
    end
    @fishes.count
  end

  def live
    births = 0
    @fishes.map! do |fish|
      if fish.zero?
        births += 1
        6
      else
        fish - 1
      end
    end
    births.times { @fishes << 8 }
  end

  private_class_method :new
end

puts Simulator.simulate(input)
