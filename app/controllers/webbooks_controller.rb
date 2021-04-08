class WebbooksController < ApplicationController
  def index
    @webbooks = Webbook.where(release: true).all
  end

  def show
    @webbook = Webbook.where(release: true).find(params[:id])
  end

  private

  def webbook_params
    params.require(:webbook)
          .permit(:title, :author, :description, :price, :release_date, :release, :image)
  end
end
