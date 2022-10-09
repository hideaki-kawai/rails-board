class SessionsController < ApplicationController
  # ログイン処理
  def create
    # Userモデルから該当するユーザーを取得
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      render 'home/index'
    end
  end

  # ログアウト処理
  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end