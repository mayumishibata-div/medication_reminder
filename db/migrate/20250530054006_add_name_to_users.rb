class AddNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, null: false, default: "名無しさん" # null: false と default を追加
  end
end
