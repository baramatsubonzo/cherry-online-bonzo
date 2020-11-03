class MypagesController < ApplicationController
  def show
    @webbooks = current_user
                  .purchase_history
                  .webbooks
  end

  private

  def page_params
    params.require(:page)
          .permit(:title, :content, :raw_order_position)
  end
end
