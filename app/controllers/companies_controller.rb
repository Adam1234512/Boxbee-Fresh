class CompaniesController < ApplicationController
  def index
    @companies = Company.search(params[:search])

    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def update
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


  private

  def company_params
    params.require(:company).permit(:name, :website_url, :description, :city, :zip, :state, :country, :logo)
  end

end
