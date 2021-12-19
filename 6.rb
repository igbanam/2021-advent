# frozen_string_literal: true

# --- Day 6: LanternFish ---

require 'debug'

filename = $PROGRAM_NAME.gsub(/\.rb$/, '')
input = File.readlines("./#{filename}.in", chomp: true)[0].split(',').map(&:to_i)
FINAL_DAY = 256

# Simulate reproduction of LanternFish through days
class Simulator

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

# Predict the number of fish after a given number of days.
class Predictor
  FISH_LIFETIME = 7

  def initialize(input)
    @count = Array.new(9, 0)
    input.each { |fish| @count[fish] += 1 }
  end

  class << self
    def predict(input)
      new(input).predict
    end
  end

  def predict
    FINAL_DAY.times do
      @count[FISH_LIFETIME] += @count[0]
      @count = @count.rotate(1)
    end

    @count.sum
  end

  private_class_method :new
end

puts Predictor.predict(input)
