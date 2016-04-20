class CreateIdfs < ActiveRecord::Migration
    def change
        create_table :idfs do |t|
            t.string :prop
            t.decimal :value

            t.timestamps null: false
        end
    end
end
