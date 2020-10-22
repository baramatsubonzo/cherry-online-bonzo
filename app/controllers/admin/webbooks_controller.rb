class Admin::WebbooksController < ApplicationController
  def index
    @webbooks = Webbook.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
