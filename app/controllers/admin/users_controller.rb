class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @user.save
      flash[:success] = t "admin.users.created", name: @user.name,
        email: @user.email
      redirect_to admin_users_path
    else
      flash[:danger] = t "admin.users.create_fail"
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.delete_success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "admin.delete_fail"
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "successupdate"
      redirect_to admin_users_path
    else
      flash[:danger] = t "failupdate"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
