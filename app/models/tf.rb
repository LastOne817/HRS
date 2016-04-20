class Tf < ActiveRecord::Base
    belongs_to :hobby

    validates :prop, presence: true

    def self.create(prop,hobby_id)
        newTf = Tf.new

        newTf.prop = prop
        newTf.value = 0.00
        newTf.hobby_id = hobby_id

        newTf.save
    end

    def self.createAll(hobby_id)
        props = Property.all
        props.each do |prop|
            newTf = Tf.new
            newTf.prop = prop.name
            newTf.value = 0.00
            newTf.hobby_id = hobby_id
            newTf.save
        end
    end

    def self.update(text,tf_id)
        tf = Tf.find(tf_id)
        prop = Property.find_by(name: tf.prop)

        keyword_count = 0

        text.split.each do |word|
            prop.keywords.each do |keyword|
                if word.include? keyword.name
                    keyword_count = keyword_count + 1
                end
            end
        end

        tf.value = Math.log(1 + keyword_count)
        tf.save
    end
end
