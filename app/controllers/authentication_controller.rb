class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user

  def login
    @user = User.find_by(user_name: params[:user_name])
    if @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: { token: token, exp: time.strftime('%m-%d-%y %H:%M'), username: @user.user_name }, status: :ok
    else
      render json: { errors: 'unauthorized' }, status: :unauthorized
    end
  end
end
