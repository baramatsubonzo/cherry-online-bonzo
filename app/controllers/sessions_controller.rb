class SessionsController < ApplicationController
  skip_before_action :login_required
  
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    # TODO: ネストを綺麗にする
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      if user.admin == true
        redirect_to admin_webbooks_path, notice: '管理者ログインしました' if user.admin == true
      else
        redirect_to root_path, notice: 'ログインしました。'
      end
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
