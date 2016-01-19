class OccupationsController < ApplicationController
  def update
    report = Report.friendly.find(params[:report_id])
    occupation = report.find_occupation(params[:id])
    occupation.update_with_actions(occupation_params, action_params)
    redirect_to report_path(report)
  end

  private

  def occupation_accepted?
    action_params.any? { |action| action != 'no' }
  end

  def action_params
    filtered_params.fetch(:actions, [])
  end

  def filtered_params
    params.permit(:notes, actions: [])
  end

  def occupation_params
    filtered_params.merge(accepted: occupation_accepted?)
  end
end
