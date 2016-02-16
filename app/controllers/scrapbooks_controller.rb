class ScrapbooksController < ApplicationController
  def create
    redirect_to new_scrapbook_search_path(scrapbook_id: Scrapbook.new_id)
  end

  def show
  end

  private

  def current_scrapbook_id
    # required for the Scrapbooking controller concern to be able to find
    # the current scrapbook
    params[:id]
  end
end
