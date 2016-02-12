class OccupationsController < ApplicationController
  def show
    @occupation = Occupation.find_by!(soc_code: params[:soc_code])
  end
end
