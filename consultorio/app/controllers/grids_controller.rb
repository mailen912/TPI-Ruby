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
      professional=params[:professional]
      puts professional
      @grid=Grid
      if params[:commit] == 'dia'
        puts "dia"
      end
      
      redirect_to (root_path)
      
    end 

end