require 'report_email_sender'

class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    keywords = params.select { |k, v| /keyword_[1|2|3]/.match(k) && !v.empty? }
    if keywords.empty?
      @error = 'Please enter at least 1 job or sector.'
      @report = Report.new
      render 'new'
    else
      @report = Report.generate_report_for_keywords(keywords.values)
      redirect_to report_path(@report)
    end
  end

  def show
    @report = Report.where(guid: params[:id]).first
    if @report.complete?
      render 'show'
    elsif @report.occupations_to_review?
      @actions = Action::ACTION_TYPES
      render 'review_occupation'
    else
      render 'select_soc_codes'
    end
  end

  def save_soc_codes
    @report = Report.where(guid: params[:id]).first
    occupation_params = params.select { |k, _v| /occupation_[\d]+/.match(k) }
    if occupation_params.empty?
      @error = 'Please select at least 1 job.'
      render 'select_soc_codes'
    else
      @report.mark_occupations_as_selected(occupation_ids(occupation_params))
      redirect_to report_path(@report)
    end
  end

  def email
    @report = Report.where(guid: params[:id]).first
    if @address.empty?
      @error = 'Please provide an email address.'
      render :show
    else
      ReportEmailSender.new(@report).send(params[:email])
      @notice = "Sent to #{params[:email]}"
      redirect_to report_path(@report)
    end
  end

  private

  def occupation_ids(occupation_params)
    occupation_params.keys.map do |occupation|
      /occupation_(\d+)/.match(occupation)[1].to_i
    end
  end
end
