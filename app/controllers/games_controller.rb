class GamesController < ApplicationController
  def new
    @letters = []
    letter_array = ('A'..'Z').to_a
    10.times { @letters.push(letter_array.sample) }
  end

  def score; end
end
