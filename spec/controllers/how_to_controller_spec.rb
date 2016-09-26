require "rails_helper"

RSpec.describe HowToController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index, scrapbook_id: Scrapbook.new_id

      expect(response).to redirect_to(root_path)
    end
  end
end
