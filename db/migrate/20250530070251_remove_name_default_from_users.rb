class RemoveNameDefaultFromUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :name, nil # nameカラムのデフォルト値を削除
  end
end
