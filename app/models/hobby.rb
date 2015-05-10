class Hobby < ActiveRecord::Base
    has_many :TFs

    validates :name, presence: true
end
