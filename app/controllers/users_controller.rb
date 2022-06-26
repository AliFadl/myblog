class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login create]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create # api name
    @user = User.new(user_params) #variable name is @user
    
    if @user.save
      render json: @user, status: :created, location: @user #returns you the resut in a json format
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end


  def login
    authenticate params[:email], params[:password]
  end
  def ali
    render json: {
          message: current_user.id
        }
  end


  def authenticate(email, password)
      command = AuthenticateUser.call(email, password)
  
      if command.success?
        render json: {
          access_token: command.result,
          message: 'Login Successful'
        }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
     end  

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
        params.permit(
          :name ,
          :email ,
          :password
        )
    end
end
