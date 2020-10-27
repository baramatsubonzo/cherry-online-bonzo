class Admin::PagesController < ApplicationController
  before_action :require_admin
  before_action :set_webbook, only:[:index, :show, :new, :edit, :update, :destroy]
  before_action :set_page, only:[:show, :edit, :update, :destroy]

  def index
    @pages = @webbook.pages.rank(:row_order)
  end

  def show
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params.merge(webbook_id: params[:webbook_id]))
    if @page.save
      flash[:success] = "新しいページを作成しました"
      redirect_to admin_webbook_pages_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @page.update(page_params)
      flash[:success] = "WEBブックを更新しました"
      redirect_to admin_webbook_pages_path
    else
      render 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to admin_webbook_pages_path, notice: "削除しました"
  end

  def sort
    @webbook = Webbook.find(params[:webbook_id])
    @page = Page.where(webbook_id: params[:webbook_id]).find(params[:id])
    @page.update(page_params)
    render nothing: true
  end

  private

  def page_params
    params.require(:page)
          .permit(:title, :content, :raw_order_position)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_webbook
    @webbook = Webbook.find(params[:webbook_id])
  end

  def set_page
    @page = Page.where(webbook_id: params[:webbook_id]).find(params[:id])
  end
end
