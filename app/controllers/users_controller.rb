class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]


  # POST /users
  def addUser
    @user = User.new(user_params)

    if @user.save
      render json: @user, except: [:created_at, :updated_at, :status], status: :ok, location: @user 
    else
      render json: @user.errors, status: :bad_request #default status: :unprocessable_entity
    end
  end

   # PATCH/PUT /users/1
   def update
    if @user.update(user_params)
      render json: @user, except: [:created_at, :updated_at, :status], status: :ok
    else
      render json: @user.errors, status: :bad_request # status: :unprocessable_entity
    end
  end

   # GET /users/1
   def show
    if(@user.status == true)
      render json: @user, except: [:created_at, :updated_at, :status], status: :ok
    else 
      if(@user.status == false)
        render status: :bad_request
      else
        render json: @user.errors, status: :bad_request
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.update(status: false) 
    render @user.status, status: :ok
  end
 
  # Login /user/login
  def login
    if (@status = User.where(email: params[:email], password: params[:password], status: true) != [])
      hmac_secret = 'my$ecretK3y'
      payload = params[:email]
      token = JWT.encode payload, hmac_secret, 'HS256'
      render json: {token: token}
    else
      if(@status = User.where(email: params[:email], password: params[:password], status: false) != [])
      render json: {msg: "Conta Desativada!"}, status: :bad_request # default status: :unprocessable_entity
      else
        render json: @status, status: :bad_request
    end
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
