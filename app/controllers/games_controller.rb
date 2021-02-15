require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @message = ""
    guess = params[:guess].upcase
    @score = guess.length.to_i
    grid = params[:letters].split
    if !english?(guess)
      @message = 'This word is not valid!'
      @score = 0
    elsif !guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
      @message = 'not enough letters in the grid'
      @score = 0
    else
      @message = 'well done!'
      @score
    end
  end

  private

  def english?(guess)
    response = open("https://wagon-dictionary.herokuapp.com/#{params[:guess]}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
