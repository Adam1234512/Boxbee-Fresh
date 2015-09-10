class BetaSurveysController < ApplicationController
  def new
    @beta_survey = BetaSurvey.new
    if session[:company_id]
      @company = Company.find_by_id(session[:company_id])
      @user = @company.user
    end
  end

  def create
    @beta_survey = BetaSurvey.new(beta_survey_params)
    BetaSurvey.parse_and_create_user(params)
    if @beta_survey.save
      flash[:notice] = "Thank you. You successfully submitted your survey. Stay tuned for updates!"
      BetaSurveyNotifier.send_beta_survey_notification_email(@beta_survey).deliver_now
      if session[:company_id]
        Rails.logger.debug("Looks like company_id is present at beta_surveys#create")
        session[:company_id] = nil
        Rails.logger.debug("Check to see if session[:company_id] went to nil #{session[:company_id]}")
        redirect_to root_path
      else
        Rails.logger.debug("Looks like company_id is NOT present at beta_surveys#create")
        redirect_to new_company_path
        session[:beta_survey_id] = @beta_survey.id
        Rails.logger.debug("Check to see if created session[:beta_survey_id] #{session[:beta_survey_id]}")
        session[:beta_survey_first_name] = @beta_survey.first_name
        session[:beta_survey_first_name] = @beta_survey.last_name
        session[:beta_survey_first_name] = @beta_survey.email
      end
    else
      flash[:error] = "There was an error submitting your survey. Please contact boxbeeinc@boxbee.com."
      render :new
    end
  end

  private

  def beta_survey_params
    params.require(:beta_survey).permit(:currently_offer_storage, {:how_manage_warehouse => []}, :offer_transport, {:how_manage_vehicles => []}, {:how_bookings_done => []}, :company_name, :company_website, :first_name, :last_name, :email, :preferred_contact_method)
  end
end
