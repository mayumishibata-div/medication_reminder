Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations' 
  }


  # ★★★ この行を追加 ★★★
  # "/dashboard" というURLにアクセスしたら、DashboardControllerのindexアクションを実行してね、という意味
  # `as: 'user_dashboard'` は、このURLに `user_dashboard_path` という名前（呼び名）をつける設定
  get 'dashboard', to: 'dashboard#index', as: 'user_dashboard'

  root 'home#index' # あなたのアプリの一番最初のページ（ランディングページ）

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener" # この行を追加
  end
end