class SignupNotifier < ApplicationMailer
  default :from => 'boxbeeinc@boxbee.com'

# send email to admins notifying that a new claim has been made.
  def send_new_company_notification_email(company)
    @company = company
    mail( :to => "kristoph@boxbee.com",
    :subject => '[Boxbee Community] A new company has been listed' )
  end
end
