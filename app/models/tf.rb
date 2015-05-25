class Tf < ActiveRecord::Base
    belongs_to :hobby

    validates :prop, presence: true
    
    def self.create(prop,hobby_id)
        @newTf = Tf.new

        @newTf.prop = prop
        @newTf.value = 0.00
        @newTf.hobby_id = hobby_id

        @newTf.save
    end

    def self.createAll(hobby_id)

        @props = Property.all
   
        @props.each do |prop|
            @newTf = Tf.new
            @newTf.prop = prop.name
            @newTf.value = 0.00
            @newTf.hobby_id = hobby_id
            @newTf.save
        end
    end

    def self.update(text,tf_id)
        @text = text #TODO: it should be changed with the file path
        @tf_id = tf_id

        @tf = Tf.find(tf_id)
        puts "done here"
        @keyword_count = 0

        while true
            @word = /\w+/.match(@text)
            if @word == nil then break end

            @text = @word.post_match
            @prop = Property.find_by(name: @tf.prop)
            @keywords = @prop.keywords
            @keywords.each do |keyword|
                if @word[0].include? keyword.name
                    @keyword_count = @keyword_count + 1
                    break
                end
            end
        end

        @tf.value = Math.log(1+@keyword_count)
        @tf.save
    end
end
