class OccupationsController < ApplicationController
  def update
    report = Report.where(guid: params[:report_id]).first
    occupation = report.find_occupation(params[:id].to_i)
    if params[:commit] == "refuse"
      occupation.accepted = false
    else
      occupation.accepted = true
    end
    occupation.save
    redirect_to report_path(report)
  end
end
