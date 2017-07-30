# frozen_string_literal: true

class Admin::UsersController < Admin::ApplicationController
  before_action :find_user, only: %i[edit update destroy]
  def index
    @users = User.search(params).deleted_at_as_0.order(:first_name).paginate(
      page: params[:page], per_page: 20
    )
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render action: :new
    end
  end

  def show
    @user = User.find(params[:id])
    @request_off = @user.request_offs.paginate(page: params[:page], per_page: 10)
  end

  def edit; end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user.update(deleted_at: Time.zone.now.to_i)
    if @user == current_user
      sign_out
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password,
                                 :first_name, :last_name, :position, :remaining_days_off,:avatar, :department_id, :birth_date, :join_date, :gender, :chatwork_id)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
