class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]


  # POST /users
  def addUser
    @user = User.new(user_params)

    if @user.save
      render json: @user, except: [:created_at, :updated_at], status: :created, location: @user 
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

   # PATCH/PUT /users/1
   def update
    if @user.update(user_params)
      render json: @user, except: [:created_at, :updated_at]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

   # GET /users/1
   def show
    render json: @user, except: [:created_at, :updated_at]
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end
 
  # Login /user/login
  def login

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :birthdate, :sex)
    end
end
