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
      render action: 'new'
    end
  end

  def show
    @report = Report.friendly.find(params[:id])
  end

  def save_soc_codes
    @report = Report.friendly.find(params[:id])
    occupation_ids = params[:occupations].keys.map(&:to_i)
    if @report.mark_occupations_as_selected(occupation_ids)
      redirect_to report_path(@report)
    else
      @error = 'Please select at least 1 job.'
      render action: 'select_soc_codes'
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

  def send_report_email(address)
    mail = Mail.new do
      from ENV["EMAIL_SENDER"]
      subject 'Work you could do'
    end
    report_view_folder = "#{Rails.root}/app/views/reports/"
    text = File.open("#{report_view_folder}report_email.txt.erb").read
    text_template = ERB.new(text)
    text_content = text_template.result(binding)
    text_part = Mail::Part.new do
      body text_content
    end
    html = File.open("#{report_view_folder}report_email.html.erb").read
    html_template = ERB.new(html)
    html_content = html_template.result(binding)
    html_part = Mail::Part.new do
      content_type 'text/html; charset=UTF-8'
      body html_content
    end
    mail["to"] = address
    mail.text_part = text_part
    mail.html_part = html_part
    mail.deliver!
  end
end
