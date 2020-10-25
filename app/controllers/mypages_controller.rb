class MypagesController < ApplicationController
  def show
    @webbooks = current_user.purchase_history.webbooks
  end
end
