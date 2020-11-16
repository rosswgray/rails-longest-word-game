require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters.push(('A'..'Z').to_a.sample) }
  end

  def score
    @answer = params[:word]
    grid_hash = params[:grid]
    @grid = JSON.parse(grid_hash)

    if in_grid?(@grid, @answer) == false
      @message = "Your word cannot be made from #{@grid}"
    elsif english_word?(@answer) == false
      @message = 'Your word no existe in Ingles!'
    else
      @message = 'Congratulations, you win!'
    end
  end

  private

  def in_grid?(grid, answer)
    answer_array = answer.split('')
    in_grid = true
    answer_array.each do |letter|
      if answer_array.count(letter) > grid.count(letter)
        in_grid = false
        break
      end
    end
    in_grid
  end

  def english_word?(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    word_data = open(url).read
    word_data_parsed = JSON.parse(word_data)
    word_data_parsed['found']
  end
end
