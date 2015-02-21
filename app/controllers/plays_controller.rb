class PlaysController < ApplicationController
  def index
    @plays = Play.all.order("title ASC")
  end

  def new
    @play = Play.new
  end

  def create
    @play = Play.new
    @play.attributes = play_params

    respond_to do |format|
      if @play.save
        format.html { redirect_to play_path(@play), notice: "Success" }
      else
        format.html { redirect_to new_play_path, notice: "Failed" }
      end
    end
  end

  def destroy
    @play = Play.find(params[:id])

    if @play.destroy
      redirect_to plays_path, notice: "Play successfully deleted!"
    end
  end

  def show
    @play = Play.find(params[:id]).analyze
  end

  private

  def play_params
    params.require(:play).permit(
      :title,
      :xml
    )
  end
end
