# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Webサイトのセキュリティ対策（必須です！）
  # これがないと、外部からの不正なデータ送信（CSRF攻撃）を防げません。
  protect_from_forgery with: :exception

  # ★★★ ここからがDevise関連の重要な設定です ★★★
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ユーザーがログインまたは新規登録に成功した後に、どこに移動させるかを設定します。
  # ここでは、ログイン後に `/dashboard` のページに移動するように指示しています。
  def after_sign_in_path_for(resource)
    user_dashboard_path
  end

  # ユーザーがログアウトした後に、どこに移動させるかを設定します。
  # ここでは、ログアウト後にアプリのトップページ（ランディングページ）に戻るように指示しています。
  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    # 新規登録（:sign_up）時に :name を受け取ることを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    # アカウント更新（:account_update）時に :name や他のカスタムカラムを受け取ることを許可
    # （将来的な設定ページのために、time_zoneなども含めておきます）
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :time_zone, :default_morning_time, :default_noon_time, :default_evening_time, :default_bedtime])
  end
end