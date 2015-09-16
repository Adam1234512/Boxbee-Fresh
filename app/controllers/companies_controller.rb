class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :destroy, :edit, :update, :approve_listing]


  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
    if session[:beta_survey_id]
      @beta_survey = BetaSurvey.find_by_id(session[:beta_survey_id])
      @session_company_info = [@beta_survey.company_name, @beta_survey.company_website]
      @session_user_info = [session[:beta_survey_first_name], session[:beta_survey_last_name], session[:beta_survey_email]]
    end
  end


  def create
    @company = Company.new(company_params)
    @company.cities = Company.parse_cities(params)
    @company.user = Company.parse_and_create_user(params)
    Rails.logger.debug("@company: #{@company.cities.all}")
    if @company.save
      flash[:notice] = "You successfully submitted your company.  We'll review your listing soon."
      if session[:beta_survey_id]
        redirect_to root_path
        session[:beta_survey_id] = nil
      else
        session[:company_id] = @company.id
        redirect_to beta_program_path
      end
      SignupNotifier.send_new_company_notification_email(@company).deliver_now
    else
      flash[:error] = "There was an error submitting your company. Please try again."
      render :new
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.js
      format.html
    end
  end

  def edit

  end

  def update

  end

  def approve_listing
    @company = Company.find(params[:id])
    @company.hold = false
    @company.save

    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :website_url, :description, :logo)
  end

end
