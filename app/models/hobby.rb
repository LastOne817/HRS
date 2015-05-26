class Hobby < ActiveRecord::Base
    has_many :tfs, :dependent => :destroy

    validates :name, presence: true

    def self.create(name,text)
        @hobby = Hobby.new(name: name)
        @hobby.text = text
        @hobby.save
        @props = Property.all

        @props.each do |prop|
            Tf.create(prop,@hobby.id)
        end

        @tfs = hobby.tfs

        @tfs.each do |tf|
            Tf.update(@hobby.text,tf.id)
        end

        Idf.update
    end
end
