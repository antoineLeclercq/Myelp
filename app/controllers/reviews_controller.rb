class ReviewsController < ApplicationController
  def recent
    @reviews = Review.all.order(created_at: :desc).limit(10)
  end
end
