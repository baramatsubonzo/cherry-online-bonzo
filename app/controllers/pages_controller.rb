class PagesController < ApplicationController
  before_action :set_webbook, only:[:index, :show]
  before_action :validate_read_webbook, only:[:show]

  def index
    @pages = @webbook.pages
  end

  def show
    @page = Page.where(webbook_id: params[:webbook_id]).find(params[:id])
  end

  private

  def page_params
    params.require(:page)
          .permit(:title, :content)
  end

  def user_has_book?
    current_user.purchase_history
      .purchase_history_webbooks
      .find_by(webbook_id: params[:webbook_id])
      .present?
  end

  def validate_read_webbook
    redirect_to root_path unless user_has_book?
  end

  def set_webbook
    @webbook = Webbook.find(params[:webbook_id])
  end
end
