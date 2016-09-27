class ScrapbooksController < ApplicationController
  def show
  end

  private

  def current_scrapbook_id
    # required for the Scrapbooking controller concern to be able to find
    # the current scrapbook
    params[:id]
  end
end
