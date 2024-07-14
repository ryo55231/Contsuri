class Public::Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = PublicUser.guest
    sign_in user
    redirect_to user_path(user), notice: "ゲストでログインしました。"
  end
end