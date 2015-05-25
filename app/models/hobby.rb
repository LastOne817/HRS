class Hobby < ActiveRecord::Base
    has_many :tfs, :dependent => :destroy

    validates :name, presence: true
end
