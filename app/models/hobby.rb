class Hobby < ActiveRecord::Base
    has_many :tfs

    validates :name, presence: true
end
