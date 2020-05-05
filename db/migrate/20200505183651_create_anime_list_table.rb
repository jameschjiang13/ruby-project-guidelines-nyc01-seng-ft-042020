class CreateAnimeListTable < ActiveRecord::Migration[5.0]
  def change
    create_table :anime_table do |t|
      t.integer :anime_id
      t.integer :list_id
    end
  end
end
