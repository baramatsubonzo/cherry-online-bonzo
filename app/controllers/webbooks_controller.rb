class WebbooksController < ApplicationController
  def index
  end

  def show
  end

  def new
    @webbook = Webbook.new
  end

  def create
    @webbook = Webbook.new(webbook_params)
    if @webbook.save
      flash[:success] = "新しいWEBブックを作成しました"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def webbook_params
    params.require(:webbook)
          .permit(:title, :author, :description, :price, :release_date, :release)
  end
end
