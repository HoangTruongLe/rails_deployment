class Public::DashboardController < Public::ApplicationController

  def index
  end

  def user_profile
    @user = current_user
  end

  def update_password_user
    @user = current_user
    if @user.valid_password?(params[:current_password]) && @user.update(user_params)
      flash[:success] = 'Change Password success'
      sign_in(current_user, :bypass => true)
      redirect_to user_profile_path
    else
      @user.errors.add(:base, 'Not the current password') unless @user.valid_password?(params[:current_password])
      render action: :user_profile
    end
  end
  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
