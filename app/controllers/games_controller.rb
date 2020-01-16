require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(8) { ('A'..'Z').to_a.sample }
  end

  def score
    @new_letters = letters = params[:letters].split('')
    word = params[:word]
    @message = score_and_message(word, letters)
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def score_and_message(attempt, grid)
    if included?(attempt.upcase, grid)
      if english_word?(attempt)
        "Congratulations! #{attempt.upcase} is a valid English word!"
      else
        "Sorry, but #{attempt.upcase} doesn't seem to be a valid English word..."
      end
    else
      "Sorry, but #{attempt.upcase} can't be built from #{grid}"
    end
  end
end
