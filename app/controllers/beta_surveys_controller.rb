class BetaSurveysController < ApplicationController
  before_action :authenticate_user!, only: [:show, :index]
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
      BetaSurveyNotifier.send_beta_survey_notification_email(@beta_survey).deliver_now
      redirect_to :thank_you
    else
      flash[:error] = "There was an error submitting your survey. Please contact boxbeeinc@boxbee.com."
      render :new
    end
  end

  def show
    @beta_survey = BetaSurvey.find(params[:id])
  end

  def thank_you

  end

  private

  def beta_survey_params
    params.require(:beta_survey).permit(:currently_offer_storage, {:how_manage_warehouse => []}, :offer_transport, {:how_manage_vehicles => []}, {:how_bookings_done => []}, :company_name, :company_website, :first_name, :last_name, :email, {:how_heard => []})
  end
end
