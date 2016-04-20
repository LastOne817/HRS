class CreateWeights < ActiveRecord::Migration
    def change
        create_table :weights do |t|
            t.text :weightList

            t.timestamps null: false
        end
    end
end
