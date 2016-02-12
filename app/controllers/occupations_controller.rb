class OccupationsController < ApplicationController
  def index
    redirect_to root_path
  end

  def show
    @occupation = Occupation.find_or_import_from_lmi(params[:soc_code])
  end
end
