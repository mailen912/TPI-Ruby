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
      type=params[:type]
      day=params[:day]
      puts day.class
      puts "tipoo"
      #puts professional
      if params[:professional_id]==""
        puts "es string vacio"
        professional=nil
      else
        professional=params[:professional_id]
      end
      @grid=Grid.new(day=day,professional=professional)
      if (not @grid.valid_day?) || (not @grid.valid_professional?)
        puts "no validoo"
      elsif type=="daily"
        @grid.export_daily
      else
        @grid.export_weekly
      end
      if params[:commit] == 'dia'
        puts "dia"
      end
      
      redirect_to (root_path)
      
    end 

end