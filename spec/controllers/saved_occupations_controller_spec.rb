require "rails_helper"

describe SavedOccupationsController do
  describe "#create" do
    let(:scrapbook) { Scrapbook.create }
    let(:occupation) { Occupation.create }

    it "associates an occupation with a scrapbook" do
      post :create, scrapbook_id: scrapbook.id, occupation_id: occupation.id

      scrapbook.reload
      expect(scrapbook.occupations).to include(occupation)
    end

    it "is idempotent" do
      post :create, scrapbook_id: scrapbook.id, occupation_id: occupation.id
      post :create, scrapbook_id: scrapbook.id, occupation_id: occupation.id
      post :create, scrapbook_id: scrapbook.id, occupation_id: occupation.id

      scrapbook.reload
      expect(scrapbook.occupations.size).to eq(1)
    end
  end
end
