class SearchesController < ApplicationController
  def show
    @query = params[:query]
    @search_results = search_for_soc_occupations(@query)
  end

  private

  def search_for_soc_occupations(query)
    LmiClient.new.soc_search(query)
             .map { |result| result["soc"] }
             .map { |soc_code| Occupation.find_or_import_from_lmi(soc_code) }
  end
end
