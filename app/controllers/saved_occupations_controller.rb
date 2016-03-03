class SavedOccupationsController < ApplicationController
  before_action :ensure_current_scrapbook

  def create
    @query = params[:query]
    @occupation = Occupation.find_by(soc_code: params[:soc_code])
    ensure_occupation_saved_to_current_scrapbook(@occupation)
  end

  def destroy
    @occupation = Occupation.find_by(soc_code: params[:soc_code])
    current_scrapbook.occupations.delete(@occupation)
  end

  private

  def ensure_occupation_saved_to_current_scrapbook(occupation)
    # rubocop:disable Lint/HandleExceptions
    current_scrapbook.occupations << occupation
  rescue ActiveRecord::RecordNotUnique
    # ignore duplicate entries
  end
end
