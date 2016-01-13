class OccupationsController < ApplicationController
  def update
    report = Report.where(guid: params[:report_id]).first
    occupation = report.find_occupation(params[:id].to_i)
    if params[:commit].downcase == "refuse"
      occupation.accepted = false
    else
      action_params = params.select { |k, _v| /action_(.*)/.match(k) }
      action_types = action_params.keys.map do |occupation|
        /action_(.*)/.match(occupation)[1]
      end
      actions_to_save = Action::ACTION_TYPES.keys.map(&:to_s) && action_types
      occupation.actions = actions_to_save.map do |action_to_save|
        Action.new(action_type: action_to_save)
      end
      occupation.accepted = true
    end
    occupation.save
    redirect_to report_path(report)
  end
end
