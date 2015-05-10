class CreateTfs < ActiveRecord::Migration
    def change
        create_table :tfs do |t|
            t.string :keyword
            t.decimal :value
            t.references :hobby, index: true

            t.timestamps null: false
        end
        add_foreign_key :tfs, :hobbies
    end
end
