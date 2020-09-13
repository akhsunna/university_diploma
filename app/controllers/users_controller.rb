class UsersController < ApplicationController
  before_action :redirect_if_logged_in, except: :logout

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(role: :user))
    if @user.save
      create_session
    else
      render :new
    end
  end

  def login
    @user = User.new
  end

  def create_session
    user = User.find_by(username: user_params[:username])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id

      redirect_to main_app.root_path
    else
      redirect_to main_app.login_users_path(invalid: 'true')
    end
  end

  def authenticate_user!
    if current_user.nil?
      redirect_to main_app.login_users_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to main_app.login_users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def redirect_if_logged_in
    redirect_to root_path if current_user
  end
end
