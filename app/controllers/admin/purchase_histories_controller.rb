class Admin::PurchaseHistoriesController < ApplicationController
  def index
    @purchase_history_webbooks = PurchaseHistoryWebbook.all
  end
end
