require "rails_helper"

describe OccupationsController do
  describe "#index" do
    it "redirects to the search page" do
      get :index, scrapbook_id: Scrapbook.new_id

      expect(response).to redirect_to(root_path)
    end
  end
end
