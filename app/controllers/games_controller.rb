require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @attempt = params[:word]
    @letters = params[:letters]
    parse(@attempt)
    if !include?(@attempt, @letters)
      @score = "Sorry but #{@attempt} can't be built from #{@letters} "
    elsif !@word['found']
      @score = "Sorry but #{@attempt} does not seem to be a valid ENGLISH word"
    else
      @score = "Congratulations, #{@attempt} is a Valid english word"
    end
  end

  def include?(attempt, letters)
    attempt.chars.all? { |letter| attempt.count(letter) <= letters.count(letter) }
  end
end

  def parse(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word_serialized = URI.open(url).read
    @word = JSON.parse(word_serialized)
  end
