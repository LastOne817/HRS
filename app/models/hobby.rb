class Hobby < ActiveRecord::Base
    has_many :tfs, :dependent => :destroy

    validates :name, presence: true

    def self.create(arg)
        hobby = Hobby.new(name: arg[:name], image: arg[:image], content: arg[:content])
        hobby.save
        
        Tf.createAll(hobby.id)

        hobby.tfs.each do |tf|
            Tf.update(hobby.content, tf.id)
        end

        Idf.update
        hobby
    end

    def self.daily_picks
        Rails.cache.fetch('hobby_daily_picks', expires_in: 1.minute) do
            self.all.shuffle.first
        end
    end
end
