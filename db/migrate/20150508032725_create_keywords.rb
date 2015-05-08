class CreateKeywords < ActiveRecord::Migration
    def change
        create_table :keywords do |t|
            t.string :title
            t.references :TF, index: true
            t.references :IDF, index: true

            t.timestamps null: false
        end
        add_foreign_key :keywords, :tfs
        add_foreign_key :keywords, :idfs
    end
end
