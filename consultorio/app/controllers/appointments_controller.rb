class AppointmentsController < ApplicationController
  load_and_authorize_resource :professional
  load_and_authorize_resource :appointment, through: :professional

  # GET /appointments
  def index
   
  end

  # GET /appointments/1
  def show
  end

  # GET /appointments/new
  def new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  def create

    if @appointment.save
      redirect_to [@professional, @appointment] , notice: 'Appointment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      redirect_to [@professional, @appointment], notice: 'Appointment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
    redirect_to  professional_appointments_url(@professional), notice: 'Appointment was successfully destroyed.'
  end

  def cancel_all
    @professional.appointments.destroy_all
    redirect_to  professional_appointments_url(@professional), notice: 'Appointments were successfully destroyed.'
  end

  private


    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:date, :name, :surname, :phone, :notes)
    end
end
