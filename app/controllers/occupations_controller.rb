class OccupationsController < ApplicationController
  def update
    report = Report.friendly.find(params[:report_id])
    occupation = report.find_occupation(params[:id])
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
    params.permit(:notes, actions: Action::ACTION_TYPES.keys)
  end
end
