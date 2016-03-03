class SavedOccupationsController < ApplicationController
  before_action :ensure_current_scrapbook

  def create
    # rubocop:disable Lint/HandleExceptions
    @query = params[:query]
    @occupation = Occupation.find_by(soc_code: params[:soc_code])

    begin
      current_scrapbook.occupations << @occupation
    rescue ActiveRecord::RecordNotUnique
      # ignore duplicate entries
    end
  end

  def destroy
    @occupation = Occupation.find_by(soc_code: params[:soc_code])
    current_scrapbook.occupations.delete(@occupation)
  end
end
