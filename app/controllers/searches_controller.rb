class SearchesController < ApplicationController
  before_action :ensure_current_scrapbook

  def show
    @query = params[:query]
    @search_results = search_for_soc_occupations(@query)
    current_scrapbook.search_log_entries << SearchLogEntry.new(query: @query)
  end

  private

  def search_for_soc_occupations(query)
    LmiForAll.new(LmiClient.new)
             .search_cache(query)
             .map { |result| OpenStruct.new(result) }
  end
end
