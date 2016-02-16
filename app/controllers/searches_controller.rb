class SearchesController < ApplicationController
  def show
    @query = params[:query]
    @search_results = search_for_soc_occupations(@query)
  end

  private

  def search_for_soc_occupations(query)
    LmiClient.new.soc_search(query)
             .map do |result|
               OpenStruct.new(result.slice("soc", "title", "description"))
             end
  end
end
