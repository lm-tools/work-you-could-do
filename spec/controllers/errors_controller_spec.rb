require "rails_helper"

describe ErrorsController do
  describe "#not_found" do
    it "returns a 404" do
      get :not_found

      expect(response.status).to eq(404)
    end
  end
end
