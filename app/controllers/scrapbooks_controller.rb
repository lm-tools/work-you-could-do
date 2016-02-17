class ScrapbooksController < ApplicationController
  def create
    params[:id] = Scrapbook.new_id unless params.include?(:id)

    if current_scrapbook.occupations.any?
      redirect_to scrapbook_path(current_scrapbook)
    else
      redirect_to new_scrapbook_search_path(current_scrapbook)
    end
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
