class Admin::WebbooksController < ApplicationController
  before_action :require_admin
  before_action :set_webbook, only:[:show, :edit, :update, :destroy]

  def index
    @webbooks = Webbook.all
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
      @page = @webbook.pages.create(webbook_id: @webbook.id, title: "表紙: #{@webbook.title}", content: "こちら表紙です", page_number: 1)
      redirect_to admin_webbook_url(@webbook.id)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @webbook.update(webbook_params)
      flash[:success] = "WEBブックを更新しました"
      redirect_to admin_root_url
    else
      render 'edit'
    end
  end

  def destroy
    @webbook.destroy
    redirect_to admin_root_path, notice: "削除しました"
  end

  private

  def webbook_params
    params.require(:webbook)
          .permit(:title, :author, :description, :price, :release_date, :release, :image)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_webbook
    @webbook = Webbook.find(params[:id])
  end
end
