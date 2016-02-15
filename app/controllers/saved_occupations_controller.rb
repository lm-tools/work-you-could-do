class SavedOccupationsController < ApplicationController
  def create
    # rubocop:disable Lint/HandleExceptions
    @occupation = Occupation.find(params[:occupation_id])
    @scrapbook = Scrapbook.find_or_create_by(id: params[:scrapbook_id])

    begin
      @scrapbook.occupations << @occupation
    rescue ActiveRecord::RecordNotUnique
      # ignore duplicate entries
    end
  end
end
