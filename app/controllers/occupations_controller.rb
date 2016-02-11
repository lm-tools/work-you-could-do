class OccupationsController < ApplicationController
  def show
    @occupation = Occupation.find(params[:id])
  end
end
