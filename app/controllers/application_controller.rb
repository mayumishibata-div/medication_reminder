# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Webサイトのセキュリティ対策（必須です！）
  # これがないと、外部からの不正なデータ送信（CSRF攻撃）を防げません。
  protect_from_forgery with: :exception

  # ★★★ ここからがDevise関連の重要な設定です ★★★

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

  # 必要に応じて、Deviseのstrong_parameters（フォームからのデータ受け取り）を設定する場所
  # 例えば、ユーザー登録時にtime_zoneなどのカスタムカラムも入力させたい場合などに使う
  # 今回はデフォルト値があるので必須ではないが、覚えておくと良い
  # before_action :configure_permitted_parameters, if: :devise_controller?
  #
  # protected
  #
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:time_zone, :default_morning_time, :default_noon_time, :default_evening_time, :default_bedtime])
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:time_zone, :default_morning_time, :default_noon_time, :default_evening_time, :default_bedtime])
  # end
end