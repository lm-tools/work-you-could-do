class ReportsController < ApplicationController
  def new
    @report = Report.new( guid: SecureRandom.hex(10) )
    @report.save
  end

  def update
    @report  = Report.friendly.find(params[:id])

    unless params['keywords'].reject(&:blank?).any?
      @error = 'Please enter at least 1 job or sector.'
      render 'new' and return
    end

    @report.keywords = Report.build_keywords_with_occupations(params['keywords'])
    @report.save
    render action: 'select_soc_codes', guid: @report.guid
  end

  def create
    @report = Report.friendly.find(params[:id]) rescue nil

    if @report == nil
      @report = Report.new(guid: params[:id])
      @report.save
      render 'new'
    else
      determine_render_from_report
    end
  end

  def show
    @report = Report.friendly.find(params[:id])
    determine_render_from_report
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

  def determine_render_from_report
    if @report.complete?
      render 'show'
    elsif @report.occupations_to_review?
      @actions = Action::ACTION_TYPES
      render 'review_occupation'
    else
      render 'select_soc_codes'
    end
  end

end
