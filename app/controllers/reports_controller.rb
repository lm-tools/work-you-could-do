class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    keywords = params.select { |k, v| /keyword_[1|2|3]/.match(k) && !v.empty? }
    if keywords.empty?
      @error = 'Please enter at least 1 job or sector.'
      @report = Report.new
      render action: 'new'
    else
      @report = Report.generate_report_for_keywords(keywords.values)
      render action: 'select_soc_codes', guid: @report.guid
    end
  end

  def save_soc_codes
    @report = Report.where(guid: params[:id]).first
    occupation_params = params.select { |k, _v| /occupation_[\d]+/.match(k) }
    if occupation_params.empty?
      @error = 'Please select at least 1 job.'
      render action: 'select_soc_codes'
    else
      @report.mark_occupations_as_selected(occupation_ids(occupation_params))
      render action: 'show'
    end
  end

  def email
    @report = Report.where(guid: params[:id]).first
    @address = params[:email]
    if @address.empty?
      @error = 'Please provide an email address.'
      render :show
    else
      send_report_email(params[:email])
      @notice = "Sent to #{params[:email]}"
      render :show
    end
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
