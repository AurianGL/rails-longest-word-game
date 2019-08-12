require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params['answer']}"
    serialized_wagon_dic = open(url).read
    word = JSON.parse(serialized_wagon_dic)
    if word["found"] == false
      @result = { score: 0, message: "not an english word" }
    elsif attempt.upcase.split(//).all? { |char| params['grid'].delete_at(params['grid'].index(char)) if params['grid'].include?(char) }
      @result = { score: word["length"], message: "well done" }
    else
      @result = { score: 0, message: "not in the grid" }
    end
  end
end

