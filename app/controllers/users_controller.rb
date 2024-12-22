class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token, only: :create
	before_action :set_user, only: %i[show edit update destroy]
	
	def index 
		@users = User.all
		render json: @users
	end

	def show
		respond_to do |format|
			format.html
			format.json { render json: @user } # Caso você queira suportar JSON também
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.role = 'USER'

		if params[:user][:photo]
      @user.photo.attach(params[:user][:photo])
    end

		if @user.save
			redirect_to @user, notice: 'User created!'
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to @user, notice: 'User updated!'
		else
			render :edit
		end
	end

	def destroy
		@user.destroy
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :phone, :role, :photo)
	end
end
