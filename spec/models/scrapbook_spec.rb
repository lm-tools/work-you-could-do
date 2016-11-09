require "spec_helper"

describe Scrapbook do
  describe "metrics" do
    let(:scrapbook) { Scrapbook.create }
    let(:occupation_1) { Occupation.create(soc_code: 1234) }
    let(:occupation_2) { Occupation.create(soc_code: 5678) }

    before do
      scrapbook.occupations << occupation_1
      scrapbook.occupations << occupation_2
    end

    it "returns a csv containing intervention ref and roles saved" do
      expected = "interventionRef,totalSavedRoles\n#{scrapbook.id},2\n"
      expect(Scrapbook.metrics).to include(expected)
    end
  end
end
