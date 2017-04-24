require "rails_helper"

require "lmi_client"

describe LmiClient do
  before do
    @lmi_client = LmiClient.new
  end

  describe "#soc_search", :vcr do
    it "returns 200" do
      response = @lmi_client.soc_search "check_authentication"
      expect(response.code).to eq(200)
    end
  end

  describe "#hours_lookup", :vcr do
    it "returns 200" do
      response = @lmi_client.hours_lookup "4135"
      expect(response.code).to eq(200)
    end
  end

  describe "#pay_lookup", :vcr do
    it "returns 200" do
      response = @lmi_client.pay_lookup "4135"
      expect(response.code).to eq(200)
    end
  end

  describe "#soc_code_lookup", :vcr do
    it "returns 200" do
      response = @lmi_client.soc_code_lookup "4135"
      expect(response.code).to eq(200)
    end
  end
end
