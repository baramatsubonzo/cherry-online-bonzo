class UsersController < ApplicationController
  skip_before_action :login_required

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @cart = @user.create_cart
      @purchase_history = @user.create_purchase_history

      log_in @user

      if @user.admin == true
        redirect_to admin_webbooks_path, notice: "ユーザー「#{@user.name}を登録しました」"
      else
        redirect_to root_path, notice: "ユーザー「#{@user.name}を登録しました」"
      end
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
