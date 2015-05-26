class HobbiesController < ApplicationController

    def new
        @hobby = Hobby.new
    end

    def index
        @hobbies = Hobby.last(20)
    end

    def show
        @hobby = Hobby.find(params[:id])
    end

    def edit
        @hobby = Hobby.find(params[:id])
    end

    def create
        hobby = Hobby.new(name: params[:hobby][:name])
        hobby.text = params[:hobby][:text]
        if hobby.save
            props = Property.all
            
            props.each do |prop|
                Tf.create(prop,hobby.id)
            end

            tfs = hobby.tfs
        
            tfs.each do |tf|
                Tf.update(hobby.text,tf.id)
            end

            Idf.update

            redirect_to hobby
        else
            render 'new'
        end
    end

    def update
        hobby = Hobby.find(params[:id])
        hobby.name = params[:hobby][:name]
        hobby.text = params[:hobby][:text]
        if hobby.save
            tfs = hobby.tfs
            text = hobby.text

            tfs.each do |tf|
                Tf.update(text,tf.id)
            end
            Idf.update

            redirect_to hobby
       else
            render 'new'
       end
    end

    def destroy
        hobby = Hobby.find(params[:id])
        hobby.destroy
    end
end
