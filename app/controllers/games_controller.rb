require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    if params[:word].chars.all? { |letter| params[:word].count(letter) <= params[:hidden].count(letter) }
      if check?(params[:word])
        @score = params[:word].size
        @message = "Good job"
        #@time = (Time.now - params[:start])
        #@time_before = params[:start]
      else
        @score = 0
        @message = "Not a real word"
      end
    else
      @score = 0
      @message = "Didn't look at the letters"
    end
  end

  def check?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
