class IdfsController < ApplicationController
      
    def createAll
        props = Property.all
        
        props.each do |prop|
            t = Idf.new(:prop => prop.name, :value => 1.00)
            t.save
        end

        redirect_to :back  #this is for temporary thing
    end

    def update
        idfs = Idf.all

        idfs.each do |idf|

            prop = idf.prop
            max = 0
            contain = 0
            hobbies = Hobby.all

            hobbies.each do |hobby|

                max = max + 1
   
                h = hobby.tfs.find_by(prop: prop)
                if h !=nil and h.value != 1
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
        redirect_to :back  #this is for temporary thing
    end
    
    def destroy
        idf = Idf.find_by(prop: params[:prop])
        idf.destroy
         redirect_to :back  #this is for temporary thing

    end
end
