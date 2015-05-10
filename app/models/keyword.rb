class Keyword < ActiveRecord::Base
    belongs_to :TF
    belongs_to :IDF

    validates :title, presence: true
end
