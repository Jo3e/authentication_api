class Api::V1::AuthenticationController < ApplicationController
    skip_before_action :authenticate_user

    def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
            token = JwtToken.encode(user_id: @user.id)
            time = Time.now + 24.hours.to_i
            render json: {
                token: token, 
                exp: time.strftime("%m-%d-%y %H:%M"), 
                name: @user.name
            }, status: :ok
        else
            render json: { error: "unauthorized"}, status: :unauthorized
        end
    end

    def signup
        @user = User.new(
            name: params[:name],
            email: params[:email],
            password: params[:password]
        )
        if @user.save!
            time = Time.now + 24.hours.to_i
            token = JwtToken.jwt_encode(user_id: @user.id, time)
            render json: {
                token: token, 
                exp: time.strftime("%m-%d-%y %H:%M"), 
                name: @user.name
            }, status: :ok
        else
            render json: { error: "unauthorized"}, status: :unauthorized
        end
    end
end
