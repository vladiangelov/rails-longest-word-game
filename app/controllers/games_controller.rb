class GamesController < ApplicationController
  def new
    @letters = Array.new(8) { ('A'..'Z').to_a.sample }
  end

  def score
    raise
  end
end
