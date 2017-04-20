class ReviewsController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def recent
    @reviews = Review.all.order(created_at: :desc).limit(10)
  end

  def new
    @business = Business.find(params[:business_id])
    @review = Review.new
  end

  def create
    @business = Business.find(params[:business_id])
    @review = @business.reviews.build(review_params.merge(user: current_user))

    if @review.save
      flash[:success] = 'Your reviews was successfully created.'
      redirect_to business_path(@business)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
