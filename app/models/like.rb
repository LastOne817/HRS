class Like < ActiveRecord::Base
   has_many :pairs
   
   belongs_to :user
end
