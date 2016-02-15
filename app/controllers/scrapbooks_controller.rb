class ScrapbooksController < ApplicationController
  def create
    redirect_to new_scrapbook_search_path(scrapbook_id: Scrapbook.new_id)
  end
end
