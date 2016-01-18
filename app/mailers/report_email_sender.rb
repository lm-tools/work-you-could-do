class ReportEmailSender
  include ApplicationHelper

  def initialize(report)
    @report = report
  end

  def send(address)
    mail = Mail.new do
      from ENV['EMAIL_SENDER']
      subject 'Work you could do'
    end
    mail['to'] = address
    mail.text_part = text_part
    mail.html_part = html_part
    mail.deliver!
  end

  private

  def report_view_folder
    "#{Rails.root}/app/views/reports/"
  end

  def text_part
    text = File.open("#{report_view_folder}report_email.txt.erb").read
    text_template = ERB.new(text)
    text_content = text_template.result(binding)
    Mail::Part.new do
      body text_content
    end
  end

  def html_part
    html = File.open("#{report_view_folder}report_email.html.erb").read
    html_template = ERB.new(html)
    html_content = html_template.result(binding)
    Mail::Part.new do
      content_type 'text/html; charset=UTF-8'
      body html_content
    end
  end
end
