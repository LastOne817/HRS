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

        uploaded_io = params[:hobby][:photo]

        if hobby.save
            

            if uploaded_io !=nil
                File.open(Rails.root.join('public', 'hobbyimage', hobby.id.to_s), 'wb') do |file|
                    file.write(uploaded_io.read)
                end
                hobby.image = "/hobbyimage/" + hobby.id.to_s
                hobby.save
            else
                hobby.image = "http://placehold.it/900x300"
                hobby.save
            end
              
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

        uploaded_io = params[:hobby][:photo]


        if hobby.save

            if uploaded_io !=nil
                File.open(Rails.root.join('public', 'hobbyimage', hobby.id.to_s), 'wb') do |file|
                    file.write(uploaded_io.read)
                end
                hobby.image = "/hobbyimage/" + hobby.id.to_s
                hobby.save
            end

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
