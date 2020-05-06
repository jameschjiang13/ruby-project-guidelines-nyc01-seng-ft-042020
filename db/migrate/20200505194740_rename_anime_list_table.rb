class RenameAnimeListTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :anime_table, :anime_list
  end
end
