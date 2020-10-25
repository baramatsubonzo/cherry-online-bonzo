class PagesController < ApplicationController
  # TODO: 公開フラグがtrueの物だけに制限する
  def index
    @webbook = Webbook.find(params[:webbook_id])
    @pages = @webbook.pages
  end

  def show
    # FYI: 購入履歴になかったら、本を読めないように制限する
    # binding.pry
    @webbook = Webbook.find_by(id: params[:webbook_id])
    redirect_to root_path unless user_has_book?

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
end
