class ProfessionalsController < ApplicationController
    before_action :find_professional, only:[:show, :edit, :update, :destroy]


    def index 
        @professionals=Professional.all
    end

    def new 
        @professional=Professional.new
    end


    
    def create #arreglar
        if @professional=Professional.create(name: params[:professional][:name]).valid?
            redirect_to( root_path)
        else
            redirect_back(fallback_location: root_path)
        end
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
        if not Appointment.where("professional_id==#{@professional.id}").first
            @professional.destroy
        end
        redirect_to( root_path)
    end

    def show
        @appointments= Appointment.where("professional_id==#{@professional.id}")
    end
    def find_professional
        @professional=Professional.find(params[:id])
    end

end
