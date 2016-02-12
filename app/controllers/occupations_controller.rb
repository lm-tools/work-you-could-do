class OccupationsController < ApplicationController
  def index
    redirect_to root_path
  end

  def show
    @occupation = Occupation.find_by!(soc_code: params[:soc_code])
  end
end
