require 'rails_helper'

RSpec.describe "Requests", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/requests/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/requests/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/requests/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/requests/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /accept" do
    it "returns http success" do
      get "/requests/accept"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /decline" do
    it "returns http success" do
      get "/requests/decline"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /complete" do
    it "returns http success" do
      get "/requests/complete"
      expect(response).to have_http_status(:success)
    end
  end

end
