class Keyword < ActiveRecord::Base
    belongs_to :TF
    belongs_to :IDF
end
