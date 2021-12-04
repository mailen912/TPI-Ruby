class GridsController < ApplicationController

      # GET /grids/new
  def new  
    @errors=[]
    @grid = Grid.new
  end

    # POST /grids
    def to_export
      @errors=[]
      puts "en export"
      
      type=params[:type]
      day=params[:day]
      puts day.class
      if  params[:day]==""
        @errors.push("Day can't be blank")
      end
      if params[:type]==""
        @errors.push("Grid field can't be blank")
      end
      if @errors.count==0
        if params[:professional_id]==""
          puts "es string vacio"
          professional=nil
        else
          professional=params[:professional_id]
        end
        @grid=Grid.new(day=day,professional=professional)
        if (not @grid.valid_day?) || (not @grid.valid_professional?)
          puts "no validoo"
          @errors.push("The day entered and/or the professional are incorrect")
        elsif type=="Daily"
          puts "entree"
          @grid.export_daily
          name="grilla_dia"
        else
          @grid.export_weekly
          name="grilla_diaria"
        end

      end
      if @errors.count==0 
        redirect_to (root_path), notice: 'The grid was downloaded correctly with the name:' + name
      else 
        render :new
      end
      
    end 

end