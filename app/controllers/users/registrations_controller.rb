class Users::RegistrationsController < Devise::RegistrationsController
  # アカウント更新後のリダイレクト先を定義
  def after_update_path_for(resource)
    # ここをユーザーダッシュボードのパスに設定
    user_dashboard_path
  end
end