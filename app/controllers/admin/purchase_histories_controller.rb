class Admin::PurchaseHistoriesController < ApplicationController
  before_action :require_admin
  
  def index
    @purchase_history_webbooks = PurchaseHistoryWebbook.all
  end

  private

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
