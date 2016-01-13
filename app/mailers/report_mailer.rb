class ReportMailer < ApplicationMailer
  default from: ENV["EMAIL_SENDER"]

  def email(email_address, report)
    @report = report
    mail(to: email_address, subject: 'Sample Email')
  end
end
