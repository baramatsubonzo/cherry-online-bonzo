class WebbooksController < ApplicationController
  def index
    @webbooks = Webbook.all
  end

  def show
    @webbook = Webbook.find(params[:id])
  end

  private

  def webbook_params
    params.require(:webbook)
          .permit(:title, :author, :description, :price, :release_date, :release, :image)
  end
end
