require "rails_helper"

describe SearchesController do
  describe "#show", :vcr do
    render_views
    it "does not blow up when no query param" do
      get :show, scrapbook_id: Scrapbook.new_id

      expect(response).to be_ok
    end
  end
end
