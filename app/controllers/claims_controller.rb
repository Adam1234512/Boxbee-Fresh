class ClaimsController < ApplicationController
  before_action :authenticate_user!
  def new
    @claim = Claim.new
    @user = current_user
    @company = current_user.companies.find_by_id(session[:company_id])
  end

  def create
    @claim = Claim.new(claim_params)
    if @claim.save
      flash[:notice] = "You successfully added your claim. We'll be in touch."
      redirect_to @claim.company
      ClaimNotifier.send_admin_claim_notification_email(@claim).deliver_now
    else
      flash[:error] = "There was an error submitting your claim. Please try again."
      render :new
    end
  end

  private
  def claim_params
    params.require(:claim).permit(:user_id, :company_id, :successfully_claimed)
  end
end
