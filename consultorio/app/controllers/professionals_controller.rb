class ProfessionalsController < ApplicationController
  load_and_authorize_resource
  #before_action :set_professional, only: [:show, :edit, :update, :destroy]

  # GET /professionals
  def index
    @professionals = Professional.all
  end

  # GET /professionals/1
  def show
  end

  # GET /professionals/new
  def new
    @professional = Professional.new
  end

  # GET /professionals/1/edit
  def edit
  end

  # POST /professionals
  def create
    @professional = Professional.new(professional_params)

    if @professional.save
      redirect_to @professional, notice: 'Professional was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /professionals/1
  def update
    if @professional.update(professional_params)
      redirect_to @professional, notice: 'Professional was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /professionals/1
  def destroy
    if @professional.destroy
      redirect_to professionals_url, notice: 'Professional was successfully destroyed.'
    else
      #tengo que avisar que no puede
      redirect_to professionals_url, notice: "The professional could not be destroyed because he/she has appointments."
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def professional_params
      params.require(:professional).permit(:name)
    end
end
