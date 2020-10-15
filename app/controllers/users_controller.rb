class UsersController < ApplicationController
  # skip_before_action :login_required

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @cart = @user.create_cart
      redirect_to root_path, notice: "ユーザー「#{@user.email}を登録しました」"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
