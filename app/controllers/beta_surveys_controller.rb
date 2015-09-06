class BetaSurveysController < ApplicationController
  def new
    @beta_survey = BetaSurvey.new
  end

  def create
    @beta_survey = BetaSurvey.new(beta_survey_params)
    if @beta_survey.save
      flash[:notice] = "Thank you. You successfully submitted your survey. Stay tuned for updates!"
      redirect_to root_path
    else
      flash[:error] = "There was an error submitting your survey. Please contact boxbeeinc@boxbee.com."
      render :new
    end
  end

  private

  def beta_survey_params
    params.require(:beta_survey).permit(:currently_offer_storage, {:how_manage_warehouse => []}, :offer_transport, {:how_manage_vehicles => []}, {:how_bookings_done => []}, :company_name, :company_website, :name, :preferred_contact_method)
  end
end
