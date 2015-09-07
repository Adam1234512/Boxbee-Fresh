class ClaimNotifier < ApplicationMailer
  default :from => 'boxbeeinc@boxbee.com'

# send email to admins notifying that a new claim has been made.
  def send_admin_claim_notification_email(claim)
    @claim = claim
    @company = @claim.company
    @user = @claim.user
    mail( :to => "kristoph@boxbee.com",
    :subject => '[Boxbee Community] A new listing claim has been submitted' )
  end
end
