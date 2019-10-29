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
    if(@user.status == true)
      render json: @user, except: [:created_at, :updated_at]
    else 
      if(@user.status == false)
        render status: 404
      else
        render json: @user.errors
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.update(status: false) 
    render status: 404
  end
 
  # Login /user/login
  def login
    if (@status = User.where(email: params[:login], password: params[:senha]) != [])
      render json: @status
    else
      render json: @status, status: :unprocessable_entity
    end
    
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
