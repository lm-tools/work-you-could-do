class ReportController < ApplicationController
  def select_soc_codes
    report = Report.where(guid: params[:guid]).first
    @keywords = report.keywords
  end

  def save_soc_codes
    report = Report.where(guid: params[:guid]).first
    occupations = params.select {|k,v| /occupation_[\d]+/.match(k) }
    if occupations.empty?
      @error = "Please select at least 1 job."
      @keywords = report.keywords
      render action: "select_soc_codes", guid: params[:guid]
    else
      # Map only the ones that were selected
      occupation_ids = occupations.keys.map do |occupation|
        /occupation_(\d+)/.match(occupation)[1].to_i
      end
      report.occupations.where(id: occupation_ids).select do |occupation|
        occupation.selected = true
        occupation.save
      end
      redirect_to controller: :report, action: :show, guid: report.guid
    end
  end

  def show
    report = Report.where(guid: params[:guid]).first
    @selected_occupations = report.occupations.where(selected: true)
  end

  def email
    report = Report.where(guid: params[:guid]).first
    @selected_occupations = report.occupations.where(selected: true)
    if params[:email].empty?
      @error = "Please provide an email address."
      render :show
    else
      # TODO: send an actual email
      @notice = "Sent to #{params[:email]}"
      render :show
    end
  end
end
