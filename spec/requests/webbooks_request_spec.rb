require 'rails_helper'

RSpec.describe "Webbooks", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/webbooks/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/webbooks/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/webbooks/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/webbooks/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
