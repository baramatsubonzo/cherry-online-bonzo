class Admin::PurchaseHistoriesController < Admin::ApplicationController
  def index
    @purchase_history_webbooks = PurchaseHistoryWebbook.all
  end
end
