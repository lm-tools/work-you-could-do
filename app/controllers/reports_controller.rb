require 'report_email_sender'

class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    @report = Report.generate_report_for_keywords(params['keywords'].values)
    if @report.save
      render action: 'select_soc_codes', guid: @report.guid
    else
      @error = 'Please enter at least 1 job or sector.'
      render action: 'new'
    end
  end

  def show
    @report = Report.where(guid: params[:id]).first
  end

  def save_soc_codes
    @report = Report.where(guid: params[:id]).first
    @report.mark_occupations_as_selected(params[:occupations].keys.map(&:to_i))
    if @report.mark_occupations_as_selected(params[:occupations].keys.map(&:to_i))
      redirect_to report_path(@report)
    else
      @error = 'Please select at least 1 job.'
      render action: 'select_soc_codes'
    end
  end

  def email
    @report = Report.where(guid: params[:id]).first
    email = params[:email]
    if email.empty?
      @error = 'Please provide an email address.'
      render :show
    else
      ReportEmailSender.new(@report).send(email)
      @notice = "Sent to #{email}"
      render :show
    end
  end
end
