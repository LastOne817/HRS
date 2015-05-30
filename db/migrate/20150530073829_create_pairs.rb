class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.references :like, index: true
      t.integer :value
      t.integer :hobby_id
      t.timestamps null: false
    end
  end
end
