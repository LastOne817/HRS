class Tf < ActiveRecord::Base
    belongs_to :hobby
    has_many :keywords
end
