class ReportsController < ApplicationController
  def new
    @report = Report.create(guid: SecureRandom.hex(10))
  end

  def update
    @report = Report.friendly.find(params[:id])

    if params['keywords'].reject(&:blank?).any?
      add_keywords_to_report(params['keywords'])
      render action: 'select_soc_codes', guid: @report.guid
    else
      @error = 'Please enter at least 1 job or sector.'
      render 'new'
    end
  end

  def create
    @report = Report.friendly.find(params[:id])
    determine_render_from_report

  rescue ActiveRecord::RecordNotFound
    @report = Report.create(guid: params[:id])
    render 'new'
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

  def add_keywords_to_report(keywords)
    @report.keywords =
      Report.build_keywords_with_occupations(keywords)
    @report.save
  end
end
