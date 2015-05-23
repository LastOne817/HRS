class Keyword < ActiveRecord::Base
    belongs_to :Property

    validates :name, presence: true
end
