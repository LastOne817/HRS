class Idf < ActiveRecord::Base
    validates :value, :numericality => { :greater_than_or_equal_to => 1 }
    validates :prop, presence: true, uniqueness: true
end
