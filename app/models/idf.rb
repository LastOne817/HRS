class Idf < ActiveRecord::Base
    has_many :keywords

    validates :value, :numericality => { :greater_than_or_equal_to => 1 }
    validates :keywords, presence: true
end
