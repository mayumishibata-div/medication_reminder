class DashboardController < ApplicationController
  # ★★★ この行を追加 ★★★
  # このコントローラーのアクション（index）を実行する前に、ユーザーがログインしているかを確認してね、という意味
  # ログインしていない場合は、自動的にログインページに移動します。
  before_action :authenticate_user!

  def index

  end
end