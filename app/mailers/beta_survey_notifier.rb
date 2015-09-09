class BetaSurveyNotifier < ApplicationMailer
  default :from => 'boxbeeinc@boxbee.com'

# send email to admins notifying that a new claim has been made.
  def send_beta_survey_notification_email(survey_result)
    @survey_result = survey_result
    mail( :to => "kristoph@boxbee.com",
    :subject => '[Boxbee Community] A new beta survey has been entered' )
  end
end
