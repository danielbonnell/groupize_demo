class PlaysController < ApplicationController
  def index
    @plays = Dir.glob("public/*.xml")
  end

  def show
  end
end
