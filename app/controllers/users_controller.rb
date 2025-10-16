class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show, edit, update ]

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: t("flash.users.update.success") }
        format.json { render :show, status: :ok, location: @user }
      else
        flash.now[:alert] = "#{t('flash.users.update.error')}: #{@user.errors.full_messages.join(', ')}"
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :photo, :phone)
  end
end
