class CreateHobbies < ActiveRecord::Migration
    def change
        create_table :hobbies do |t|
            t.string :name
            t.string :text
            t.binary :image

            t.timestamps null: false
        end
    end
end
