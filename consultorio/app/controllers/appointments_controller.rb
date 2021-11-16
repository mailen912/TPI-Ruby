require 'date'
class AppointmentsController < ApplicationController
  before_action :find_professional, only:[:show, :edit, :update, :destroy]
  def show
  end

  def new 
    puts ("acaaaaaa aaaaaa")
    puts(params[:id])
    @appointment=Appointment.new
  end



  def create #arreglar
    date=DateTime.parse("2021-01-11 11:00")
    Appointment.create(date:date,name:"Adrian",surname:"Perez",phone:"1232123", professional_id:1)
    if @appointment=Appointment.create(date: date, name: params[:professional][:name],surname: params[:professional][:surname],phone: params[:professional][:phone],professional_id:1).valid?
        redirect_to( root_path)
    else
        redirect_back(fallback_location: root_path)
    end
  end


  def destroy
    @appointment.destroy
    redirect_back(fallback_location: root_path)
  end


  def find_professional
    @appointment=Appointment.find(params[:id])
  
end
end
