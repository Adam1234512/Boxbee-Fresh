class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
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

  def edit
    @company = current_user.companies.find(params[:id])
  end

  def update
    @company = current_user.companies.find(params[:id])
    @company.cities = Company.parse_cities(params)
    @company.assign_attributes(company_params)
    if @company.save
      flash[:notice] = "Your company profile was successfully updated."
      redirect_to @company
    else
      flash[:error] = "Your post could not be updated. Please try again."
      render :edit
    end

  end

  def create
    @company = Company.new(company_params)
    # @company.user = current_user
    # @session_user_info = [@beta_survey.name, @beta_survey.email]
    @company.guest = guest_user
    @company.cities = Company.parse_cities(params)
    if @company.save
      session[:company_id] = @company.id
      if session[:beta_survey_id]
        #create a user for them
        @beta_survey = BetaSurvey.find_by_id(session[:beta_survey_id])
        u = User.new(first_name: "#{@beta_survey.first_name}", last_name: "#{@beta_survey.last_name}", email: "#{@beta_survey.email}")
        u.skip_confirmation!
        u.save!
        @company.user = u
        @company.save!
        redirect_to root_path
        session[:beta_survey_id] = nil
      else
        #let them create user manually
        flash[:notice] = "You successfully added your company"
        redirect_to new_user_registration_path
      end
      SignupNotifier.send_new_company_notification_email(@company).deliver_now
    else
      flash[:error] = "There was an error adding your company. Please try again."
      render :new
    end
  end

  def show
    @company = Company.find(params[:id])
    @user = current_user
    session[:company_id] = @company.id
  end

  def complete
  end


  private

  def company_params
    params.require(:company).permit(:name, :website_url, :description, :logo)
  end

end
