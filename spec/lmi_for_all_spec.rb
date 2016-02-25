require "spec_helper"

require "lmi_for_all"
require "lmi_client"

describe LmiForAll do
  let(:lmi_client) { double(LmiClient) }
  let(:lmi_for_all) { described_class.new(lmi_client) }

  describe "#lookup" do
    let(:soc_code_details) do
      {
        title: title,
        description: description,
        add_titles: additional_titles,
        tasks: tasks,
        qualifications: qualifications,
      }
    end
    let(:hours_details) { double(:hours_details) }
    let(:pay_details) { double(:pay_details) }
    let(:title) { "Occupation title" }
    let(:description) { "Occupation description" }
    let(:tasks) { "Occupation tasks" }
    let(:qualifications) { "Occupation qualifications" }
    let(:additional_titles) do
      [title_too_short] + [title_with_parenthesis] + [valid_title] * 30
    end
    let(:title_too_short) { "no" }
    let(:title_with_parenthesis) { "Occupation (with parenthesis)" }
    let(:valid_title) { "occupation, with, commas, manager" }
    let(:soc_code) { double(:soc_code) }

    before do
      allow(lmi_client).to receive(:hours_lookup) { hours_details }
      allow(lmi_client).to receive(:pay_lookup) { pay_details }
      allow(lmi_client).to \
        receive(:soc_code_lookup) { soc_code_details.deep_stringify_keys }
    end

    subject(:result) { lmi_for_all.lookup(soc_code) }

    it "returns the correct details" do
      expect(result[:soc_code]).to eq(soc_code)
      expect(result[:title]).to eq(title)
      expect(result[:description]).to eq(description)
      expect(result[:tasks]).to eq(tasks)
      expect(result[:qualifications]).to eq(qualifications)
      expect(result[:week_pay]).to eq(pay_details)
      expect(result[:week_hours]).to eq(hours_details)
    end

    it "returns the first 20 formattable additional titles" do
      expect(result[:additional_titles].split("; ").size).to eq(20)
    end

    it "does not return additional titles that are shorter than 4 letters" do
      expect(result[:additional_titles].split("; "))
        .not_to include(title_too_short)
    end

    it "does not return additional titles that have parentheses in them" do
      expect(result[:additional_titles].split("; "))
        .not_to include(title_with_parenthesis)
    end

    it "reformats additional titles containing commas" do
      expect(result[:additional_titles].split("; "))
        .to include("With, Commas, Manager Occupation")
    end

    context "occupation title contains n.e.c." do
      let(:title) { "Elementary cleaning occupations n.e.c." }
      let(:description) do
        "Workers doing stuff not elsewhere classified in MINOR GROUP 923."
      end
      it "cleans the title" do
        expect(result[:title]).to eq("Elementary cleaning occupations")
      end
      it "cleans the description" do
        expect(result[:description]).to eq(
          "Workers doing stuff."
        )
      end
    end
  end

  describe "#search" do
    # rubocop:disable Metrics/LineLength
    it "returns sliced results from the LMIClient" do
      lmi_client_search_results = [
        { "soc" => 1111, "title" => "Result 1", "description" => "Description 1", "additional" => "additional 1", "field" => "field 1" },
        { "soc" => 1112, "title" => "Result 2", "description" => "Description 2", "additional" => "additional 2", "field" => "field 2" },
        { "soc" => 1113, "title" => "Result 3", "description" => "Description 3", "additional" => "additional 3", "field" => "field 3" },
      ]

      expected_results = [
        { soc: 1111, title: "Result 1", description: "Description 1" },
        { soc: 1112, title: "Result 2", description: "Description 2" },
        { soc: 1113, title: "Result 3", description: "Description 3" },
      ]

      allow(lmi_client).to \
        receive(:soc_search).with("search query") { lmi_client_search_results }

      expect(lmi_for_all.search("search query")).to eq(expected_results)
    end

    it "cleans up n.e.c. titles in search results" do
      lmi_client_search_results = [
        { "soc" => 1111, "title" => "Result 1 n.e.c.", "description" => "Description 1" },
      ]

      allow(lmi_client).to \
        receive(:soc_search).with("search query") { lmi_client_search_results }

      title = lmi_for_all.search("search query").first[:title]

      expect(title).to eq("Result 1")
    end

    it "cleans up n.e.c. descriptions in search results" do
      lmi_client_search_results = [
        { "soc" => 1111, "title" => "Result 1", "description" => "Description 1 not elsewhere classified in MINOR GROUP Result 1." },
      ]

      allow(lmi_client).to \
        receive(:soc_search).with("search query") { lmi_client_search_results }

      title = lmi_for_all.search("search query").first[:description]

      expect(title).to eq("Description 1.")
    end
  end
end
