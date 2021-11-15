class ProfessionalsController < ApplicationController
    before_action :find_professional, only:[:show, :edit, :update, :destroy]

    def show
    end

    def index 
        @professionals=Professional.all
    end

    def new 
        @professional=Professional.new
    end


    
    def create #arreglar
        @professional=Professional.create(name: params[:professional][:name])
        render json: @professional
    end

    def edit #rename
        
        

    end

    def update
        if @professional.update(name: params[:professional][:name])
            redirect_to( root_path)
        else
            redirect_back(fallback_location: root_path)
        end

    end
    def destroy
        puts @professional.id
        puts @professional.name
        @professional.destroy
        redirect_to( root_path)
    end

    def find_professional
        @professional=Professional.find(params[:id])
    end

end
