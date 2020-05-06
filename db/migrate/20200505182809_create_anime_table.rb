class CreateAnimeTable < ActiveRecord::Migration[5.0]
  def change
    create_table :animes do |t|
      t.integer :producer_id
      t.integer :rating
      t.string :title
      t.text :synopsis
    end
  end
end
