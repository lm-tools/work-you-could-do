class ReportsController < ApplicationController

  require 'lmi_for_all'

  def gather_keywords
    @report = Report.new(guid: params['id'])
  end

  def new
    @report = Report.new(report_params)
    @search_results = Hash[
        params[:keywords].map do |k|
          [k, search_for_soc_occupations(k)]
        end
    ]
    render 'select_soc_codes'
  end

  def report_params
    params.permit(:report, :keywords)
  end

  #---------------------------

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

  # takes a keyword and returns a list of SocOccupation models
  # this actually does the search, and also, hydrates the SocOccupation, and also, caches it in the DB.
  # YAY
  def search_for_soc_occupations(keyword)
    lmi_client = LmiClient.new
    lmi_client.occupation_search(keyword)
  end
end
