class CompaniesController < ApplicationController
  def index
    @companies = Company.search(params[:search])
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
    if @company.update_attributes(company_params)
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
    if @company.save
      session[:company_id] = @company.id
      flash[:notice] = "You successfully added your company"
      if current_user
        redirect_to @company
      else
        redirect_to new_user_registration_path
      end
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
    params.require(:company).permit(:name, :website_url, :description, :city, :zip, :state, :country, :logo)
  end

end
