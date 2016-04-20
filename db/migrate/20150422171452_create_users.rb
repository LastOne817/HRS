class CreateUsers < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :provider
            t.string :uid
            t.string :username
            t.string :password
            t.string :email
            t.binary :image
            t.string :token
    	    t.string :salt 
            t.datetime :expires_at
            t.text :checklist

            t.timestamps null: false
        end
       add_foreign_key :users, :likes
       add_foreign_key :users, :dislikes

    end
end
