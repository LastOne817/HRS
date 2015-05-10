class CreateArticles < ActiveRecord::Migration
    def change
        create_table :articles do |t|
            t.integer :hobby_first
	    t.integer :hobby_second
	    t.integer :hobby_third
	    t.integer :hobby_fourth

            t.timestamps null: false
        end
        add_foreign_key :articles, :users
    end
end
