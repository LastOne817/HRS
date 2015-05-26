class CreateArticles < ActiveRecord::Migration
    def change
        create_table :articles do |t|
            t.integer :hobby_first
	    t.integer :hobby_second
	    t.integer :hobby_third
	    t.integer :hobby_fourth
            t.decimal :similarity_first
            t.decimal :similarity_second
            t.decimal :similarity_third
            t.decimal :similarity_fourth

            t.timestamps null: false
        end
        add_foreign_key :articles, :users
    end
end
