class Grid
    attr_accessor :day, :professional
    def initialize(day=nil, professional=nil)
        self.day=day
        self.professional=professional 
    end       

    def valid_day?
        begin
            DateTime.strptime(self.day , "%Y-%m-%d")
            return true
        rescue => exception
            return false #No es valida la fecha
        end   
    end 
    
    def valid_professional?
        if self.professional.nil? || Professional.where(id:self.professional).first
            true
        else
            false
        end
    end

    def self.get_week(day)
      day_date = Date.strptime(day, "%Y-%m-%d")
      week=day_date.all_week 
      week=week.to_a
    end

    def self.generating_grid(type,appointments, day,entry, output)
      schedule=Appointment.schedule
      if type=="weekly"
        semana=%w[lunes martes miercoles jueves viernes sabado domingo]
        week=Grid.get_week(day)
      end
      template = ERB.new (Rails.root.join("#{entry}")).read
      File.open( "#{Dir.home}/#{output}", "w+") do |f|
         f.write(template.result binding)
      end
    end

    def self.get_appointments(type,day,professional=nil)
      if type == "weekly"
        week=Grid.get_week(day) 
        appointments=Appointment.by_date(week)
      else
        appointments=Appointment.by_date(day)
      end
      appointments=appointments.where(professional_id: professional) if professional
      return appointments
    end

    def export_daily
      type="daily"
      appointments=Grid.get_appointments(type,self.day, self.professional)
      Grid.generating_grid(type,appointments, self.day,'app/templates/grids/daily.html.erb','daily_grid.html')
    end

    def export_weekly
      type="weekly"
      appointments=Grid.get_appointments(type,self.day, self.professional)
      Grid.generating_grid(type,appointments, self.day,'app/templates/grids/weekly.html.erb','weekly_grid.html')
    end
end