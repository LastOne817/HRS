class Idf < ActiveRecord::Base
    validates :prop, presence: true, uniqueness: true

    def self.createAll
        Property.all.each do |prop|
            t = Idf.new(:prop => prop.name, :value => 0.00)
            t.save
        end
    end


    def self.update
        Idf.all.each do |idf|
            max = 0
            contain = 0
            Hobby.all.each do |hobby|
                max = max + 1

                h = hobby.tfs.find_by(prop: idf.prop)
                if h != nil and h.value != 0
                    contain = contain + 1
                end
            end

            if contain != 0
                idf.value = Math.log(Float(max)/Float(contain))
            else
                idf.value = 0
            end
            idf.save
        end
    end

end
