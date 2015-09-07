class CompaniesController < ApplicationController
  before_action :authenticate_user!
  def index
    @companies = Company.search(params[:search])
    @companies_all = Company.all
    @no_companies = @companies.length < 1

    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @company = Company.new
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
    @company.user = current_user
    @company.guest = guest_user
    @company.cities = Company.parse_cities(params)
    if @company.save
      session[:company_id] = @company.id
      flash[:notice] = "You successfully added your company"
      if current_user
        redirect_to @company
      else
        redirect_to new_user_registration_path
      end
      SignupNotifier.send_new_company_notification_email(@company).deliver_now
    else
      flash[:error] = "There was an error adding your company. Please try again."
      render :new
    end
  end

  def show
    @company = current_user.companies.find(params[:id])
    @user = current_user
    session[:company_id] = @company.id
  end


  private

  def company_params
    params.require(:company).permit(:name, :website_url, :description, :logo)
  end

end
