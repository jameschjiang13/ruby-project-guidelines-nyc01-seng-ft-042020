class RenameAnimeListTableAgain < ActiveRecord::Migration[5.0]
  def change
    rename_table :anime_list, :anime_lists
  end
end
