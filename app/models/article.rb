class Article < ActiveRecord::Base 
    has_many :comments, dependent: :destroy
    validates :hobby_first, presence: true
    validates :hobby_second, presence: true
    validates :hobby_third, presence: true
    validates :hobby_fourth, presence: true
end
