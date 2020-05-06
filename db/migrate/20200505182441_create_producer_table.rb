class CreateProducerTable < ActiveRecord::Migration[5.0]
  def change
    create_table :producers do |t|
      t.string :name
    end
  end
end
