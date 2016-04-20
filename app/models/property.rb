class Property < ActiveRecord::Base
    has_many :keywords

    validates :name, presence: true
end
