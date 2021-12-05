class GridsController < ApplicationController

      # GET /grids/new
  def new  
    @errors=[]
    @grid = Grid.new
  end

    # POST /grids
    def to_export
      @errors=[]
      type=params[:type]
      day=params[:day]
      if  params[:day]==""
        @errors.push("Day can't be blank")
      end
      if params[:type]==""
        @errors.push("Grid field can't be blank")
      end
      if @errors.count==0
        if params[:professional_id]==""
          professional=nil
        else
          professional=params[:professional_id]
        end
        @grid=Grid.new(day=day,professional=professional)
        if (not @grid.valid_day?) || (not @grid.valid_professional?)
          @errors.push("The day entered and/or the professional are incorrect")
        elsif type=="Daily"
          @grid.export_daily
          name="daily_grid"
        else
          @grid.export_weekly
          name="weekly_grid"
        end

      end
      if @errors.count==0 
        redirect_to (root_path), notice: 'The grid was downloaded correctly with the name:' + name
      else 
        render :new
      end
      
    end 

end