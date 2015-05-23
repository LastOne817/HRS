class Property < ActiveRecord::Base
    has_many :Keywords

    validates :name, presence: true
end
