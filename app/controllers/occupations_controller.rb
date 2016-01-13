class OccupationsController < ApplicationController
  def update
    report = Report.find_for_guid(params[:report_id])
    occupation = report.find_occupation(params[:id].to_i)
    occupation.accepted = occupation_accepted?(params)
    occupation.actions = action_instances_to_save(params)
    occupation.save
    redirect_to report_path(report)
  end

  private

  def occupation_accepted?(params)
    params[:commit].downcase != 'refuse'
  end

  def action_instances_to_save(params)
    action_params = params.select { |k, _v| /action_(.*)/.match(k) }
    action_types = action_params.keys.map do |action|
      /action_(.*)/.match(action)[1]
    end
    actions_to_save = Action::ACTION_TYPES.keys.map(&:to_s) && action_types
    actions_to_save.map do |action_to_save|
      Action.new(action_type: action_to_save)
    end
  end
end
