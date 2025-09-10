class Api::V1::SessionsController < ApplicationController
    def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: { message: "ログイン成功", user: { id: user.id, name: user.name, email: user.email } }, status: :ok
    else
      render json: { message: "メールアドレスまたはパスワードが違います" }, status: :unauthorized
    end
  end
end
