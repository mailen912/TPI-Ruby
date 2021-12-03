class GridsController < ApplicationController

      # GET /grids/new
  def new
    @grid = Grid.new
  end

    # POST /grids
    def to_export
      puts "en export"
      puts params[:day]
      puts params[:professional_id]
      puts params[:type]
      day=params[:day]
      puts day.class
      
      #puts professional
      if params[:professional_id]==""
        puts "es string vacio"
        professional=nil
      else
        professional=params[:professional_id]
      end
      @grid=Grid.new(day=day,professional=professional)
      if @grid.valid_day? and @grid.valid_professional?
        puts "validoo"
        
        @grid.export_daily
      end
      if params[:commit] == 'dia'
        puts "dia"
      end
      
      redirect_to (root_path)
      
    end 

end