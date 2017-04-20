class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You have successfully been signed in.'
      redirect_to root_path
    else
      flash[:error] = 'Unable to sign you in, Email or Password is invalid.'
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have been signed out.'
    redirect_to root_path
  end
end
