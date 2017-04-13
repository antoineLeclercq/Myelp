class BusinessesController < ApplicationController
  def index
    @businesses = Business.all.order(created_at: :desc)
  end
end
