class BetaSurveyNotifier < ApplicationMailer
  default :from => 'boxbeeinc@boxbee.com'

# send email to admins notifying that a new claim has been made.
  def send_beta_survey_notification_email(survey_result)
    @survey_result = survey_result
    emails = ['boxbeeinc@boxbee.com', 'beta@boxbee.com']
    mail( :to => emails,
    :subject => '[Boxbee Community] A new beta survey has been entered' )
  end
end
