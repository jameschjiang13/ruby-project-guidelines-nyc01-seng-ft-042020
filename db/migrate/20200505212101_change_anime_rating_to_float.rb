class ChangeAnimeRatingToFloat < ActiveRecord::Migration[5.0]
  def change
    change_column :animes, :rating, :float
  end
end
