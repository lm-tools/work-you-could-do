class SearchesController < ApplicationController
  def show
    @query = params[:query]
    @search_results = search_for_soc_occupations(@query)
  end

  private

  def search_for_soc_occupations(query)
    LmiForAll.new(LmiClient.new)
             .search(query)
             .map { |result| OpenStruct.new(result) }
  end
end
