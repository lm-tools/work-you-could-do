class ScrapbooksController < ApplicationController
  def create
    params[:id] = Scrapbook.new_id unless params.include?(:id)
    entrypoint_path = if current_scrapbook.saved_occupations.any?
                        new_scrapbook_search_path(current_scrapbook)
                      else
                        scrapbook_introduction_path(current_scrapbook)
                      end
    redirect_to entrypoint_path
  end

  def show; end

  private

  def current_scrapbook_id
    # required for the Scrapbooking controller concern to be able to find
    # the current scrapbook
    params[:id]
  end
end
