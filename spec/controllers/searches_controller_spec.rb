require "rails_helper"

describe SearchesController do
  describe "#new" do
    render_views

    let(:scrapbook) { Scrapbook.create(id: Scrapbook.new_id) }

    subject(:page) do
      get :new, scrapbook_id: scrapbook.id

      Capybara.string(response.body)
    end

    context "given saved roles" do
      before { scrapbook.occupations << Occupation.create(soc_code: 1234) }

      it "displays a prominent link to the current scrapbook" do
        expect(page).to have_selector(
          ".information-box a[href='#{scrapbook_path(scrapbook)}']"
        )
      end
    end

    context "given no saved roles" do
      it "does not display a link to the current scrapbook" do
        expect(page).to have_no_link(href: scrapbook_path(scrapbook))
      end
    end
  end

  describe "#show", :vcr do
    render_views
    it "does not blow up when no query param" do
      get :show, scrapbook_id: Scrapbook.new_id

      expect(response).to be_ok
    end

    it "saves search queries to the current scrapbook's search log" do
      scrapbook_id = Scrapbook.new_id

      get :show, scrapbook_id: scrapbook_id, query: "library"
      get :show, scrapbook_id: scrapbook_id, query: "plumber"
      get :show, scrapbook_id: scrapbook_id, query: ""
      get :show, scrapbook_id: scrapbook_id
      get :show, scrapbook_id: scrapbook_id, query: "driving"

      current_scrapbook = Scrapbook.find(scrapbook_id)
      search_log = current_scrapbook.search_log_entries.map(&:query)

      expect(search_log).to eq(["library", "plumber", "", nil, "driving"])
    end
  end
end
