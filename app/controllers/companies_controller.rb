class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def update
  end

  def create
    @company = Company.build(company_params)
    if @company.save
      flash[:notice] = "You successfully added your company"
      redirect_to root_path #need to fix this.
    else
      flash[:error] = "There was an error adding your company. Please try again."
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :website_url, :description, :city, :zip, :state, :country, :logo)
end
