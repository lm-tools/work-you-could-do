class SavedOccupationsController < ApplicationController
  before_action :ensure_current_scrapbook

  def create
    # rubocop:disable Lint/HandleExceptions
    @query = params[:query]
    @occupation = Occupation.find(params[:occupation_id])

    begin
      current_scrapbook.occupations << @occupation
    rescue ActiveRecord::RecordNotUnique
      # ignore duplicate entries
    end
  end
end
