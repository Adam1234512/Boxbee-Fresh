class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  #For autocomplete-rails
  autocomplete :city, :name
  def index
    @companies = Company.search(params[:search])
    @companies_all = Company.all
    @no_companies = @companies.length < 1
    @city = params[:search]
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
    @company.cities = Company.parse_city(params)
    @company.user = Company.parse_and_create_user(params)
    if @company.save
      if session[:beta_survey_id]
        Rails.logger.debug("Looks like beta_survey_id is present at companies#create")
        redirect_to root_path
        session[:beta_survey_id] = nil
        flash[:notice] = "You successfully submitted your company.  We'll review your listing soon."
        Rails.logger.debug("Check to make sure session[:beta_survey_id] set to nil #{session[:beta_survey_id]}")
      else
        Rails.logger.debug("Looks like beta_survey_id is NOT present at companies#create")
        session[:company_id] = @company.id
        Rails.logger.debug("Created session[:company_id] #{session[:company_id]}")
        redirect_to beta_program_path
      end
      SignupNotifier.send_new_company_notification_email(@company).deliver_now
    else
      flash[:error] = "There was an error submitting your company. Please try again."
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :website_url, :description, :logo)
  end

end
