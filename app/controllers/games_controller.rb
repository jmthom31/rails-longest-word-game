require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    letter_array = ('a'..'z').to_a
    @letters = letter_array.sample(10)
  end

  def english_word(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}/"
    dictionary = URI.open(url).read
    word = JSON.parse(dictionary)

    if word["found"] != true
      @result = "Not a valid English word"
    end
  end

  def valid_word(attempt, letters)
    if attempt.chars.all? { |letter| attempt.count(letter) <= letters.count(letter) }
      @result = "Woo"
    else
      @result = "Not valid word"
    end
  end

  def score
    @letters = params[:letter_array]
    @attempt = params[:attempt]

    @vailid_word = valid_word(@attempt, @letters)
    @english_word = english_word(@attempt)
  end

end
