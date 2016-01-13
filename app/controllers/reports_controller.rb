require 'report_email_sender'

class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    @report = Report.generate_report_for_keywords(params['keywords'])
    if @report.save
      render action: 'select_soc_codes', guid: @report.guid
    else
      @error = 'Please enter at least 1 job or sector.'
      render 'new'
    end
  end

  def show
    @report = Report.friendly.find(params[:id])
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
    @report = Report.friendly.find(params[:id])
    occupation_ids = params[:occupations].keys.map(&:to_i)
    if @report.mark_occupations_as_selected(occupation_ids)
      redirect_to report_path(@report)
    else
      @error = 'Please select at least 1 job.'
      render 'select_soc_codes'
    end
  end

  def email
    @report = Report.friendly.find(params[:id])
    email = params[:email]
    if email.empty?
      @error = 'Please provide an email address.'
    else
      ReportEmailSender.new(@report).send(email)
      @notice = "Sent to #{email}"
    end
    render :show
  end

  private

  def occupation_ids(occupation_params)
    occupation_params.keys.map do |occupation|
      /occupation_(\d+)/.match(occupation)[1].to_i
    end
  end
end
