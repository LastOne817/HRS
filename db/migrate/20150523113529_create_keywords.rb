class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.references :property, index: true 
 
      t.string :name
      t.timestamps null: false
    end
    add_foreign_key :keywords, :properties
  end
end
