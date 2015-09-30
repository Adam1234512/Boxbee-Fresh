class BetaSurveyAutoresponder < ApplicationMailer
  default :from => 'boxbeeinc@boxbee.com'

  # send email to beta survey applicant.
  def send_beta_survey_autoresponder_email(email)
    mail( :to => "#{email}",
    :subject => '[Boxbee On Demand Storage Beta] Confirming your entry' )
  end
end
