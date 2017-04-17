class BusinessesController < ApplicationController
  def index
    @businesses = Business.all.order(created_at: :desc)
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    if @business.save
      flash[:success] = 'Your business was successfully created.'
      redirect_to businesses_path
    else
      render :new
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :street, :city, :state, :zipcode, :area, :phone)
  end
end
