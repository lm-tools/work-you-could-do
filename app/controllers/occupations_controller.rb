class OccupationsController < ApplicationController
  def update
    report = Report.find_for_guid(params[:report_id])
    occupation = report.find_occupation(params[:id].to_i)
    if occupation_accepted?(params)
      occupation.mark_as_accepted_with_actions(action_params)
    else
      occupation.mark_as_refused
    end
    redirect_to report_path(report)
  end

  private

  def occupation_accepted?(params)
    params[:commit].downcase != 'refuse'
  end

  def action_params
     params.select {|key, value| ["actions", "notes"].include?(key) }
  end
end
