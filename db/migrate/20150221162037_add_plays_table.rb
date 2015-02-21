class AddPlaysTable < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.string :title, null: false
      t.text :xml, null: false
      t.timestamps
    end
  end
end
