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
        hobby.content = params[:hobby][:content]
        if hobby.save
            
            Tf.createAll(hobby.id)
            
            tfs = hobby.tfs
        
            tfs.each do |tf|
                Tf.update(hobby.content,tf.id)
            end

            Idf.update

            redirect_to hobby
        end
    end

    def update
        hobby = Hobby.find(params[:id])
        hobby.name = params[:hobby][:name]
        hobby.content = params[:hobby][:content]
        if hobby.save
            tfs = hobby.tfs
            content = hobby.content

            tfs.each do |tf|
                Tf.update(content,tf.id)
            end
            Idf.update

            redirect_to hobby
       end
    end

    def destroy
        hobby = Hobby.find(params[:id])
        hobby.destroy
        redirect_to hobbies_path
        #else
        #    redirect_to :back
        #end
    end
end
