class HobbiesController < ApplicationController
    def create
        hobby = Hobby.new(name: params[:name])
    
        hobby.save

        props = Property.all

        props.each do |prop|
            Tf.create(prop,hobby.id)
        end

        Idf.update
    end

    def update
        hobby = Hobby.find(name: params[:name])
        tfs = hobby.tfs
        text = params[:text]   # its form can be changed

        tfs.each do |tf|
            Tf.update(text,tf.id)
        end

        Idf.update

    end

    def delete
        hobby = Hobby.find(name: params[:name])
        hobby.destroy
    end
end
