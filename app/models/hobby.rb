class Hobby < ActiveRecord::Base
    has_many :tfs, :dependent => :destroy

    validates :name, presence: true

    def self.create(arg)
        hobby = Hobby.new(name: arg[:name], content: arg[:content])
        hobby.save
        
        Tf.createAll(hobby.id)

        tfs = hobby.tfs

        tfs.each do |tf|
            Tf.update(hobby.content, tf.id)
        end

        Idf.update
    end
end
