class ReportsController < ApplicationController

  def new
    @report = Report.new
  end

  def create
    keywords = params.select {|k,v| /keyword_[1|2|3]/.match(k) && !v.empty? }
    if keywords.empty?
      @error = "Please enter at least 1 job or sector."
      @report = Report.new
      render action: "new"
    else
      @report = Report.generate_report_for_keywords(keywords.values)
      render action: "select_soc_codes", guid: @report.guid
    end
  end

  def save_soc_codes
    @report = Report.where(guid: params[:id]).first
    occupations = params.select {|k,v| /occupation_[\d]+/.match(k) }
    if occupations.empty?
      @error = "Please select at least 1 job."
      render action: "select_soc_codes"
    else
      # Map only the ones that were selected
      occupation_ids = occupations.keys.map do |occupation|
        /occupation_(\d+)/.match(occupation)[1].to_i
      end
      @report.occupations.where(id: occupation_ids).select do |occupation|
        occupation.selected = true
        occupation.save
      end
      render action: "show"
    end
  end

  def email
    @report = Report.where(guid: params[:id]).first
    if params[:email].empty?
      @error = "Please provide an email address."
      render :show
    else
      @notice = "Sent to #{params[:email]}"
      render :show
    end
  end
end
