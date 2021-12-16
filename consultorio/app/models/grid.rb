class Grid
    #validate :day
    #validates :professional, presence: false 
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
        days=%w[lunes martes miercoles jueves viernes sabado domingo]
        week=Grid.get_week(day)
      end
      template = ERB.new (Rails.root.join("#{entry}")).read
      puts template.result binding
      File.open( "#{Dir.home}/#{output}", "w+") do |f|
         f.write(template.result binding)
    end
    end

    def export_daily
      
      #if professional.nil?
        appointments=Appointment.by_day(self.day)
        appointments=appointments.where(professional_id: professional) if professional
      #else
       # appointments=Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", self.day, self.professional )
      #end
      type="daily"
      Grid.generating_grid(type,appointments, self.day,'app/templates/grids/daily.html.erb','daily_grid.html')
       #template = ERB.new (Rails.root.join('app/templates/grids/daily.html.erb')).read
      
       # File.open( "#{Dir.home}/daily_grid.html", "w+") do |f|
       #     f.write(template.result binding)
       # end
      end

      def export_weekly
        week=Grid.get_week(self.day)   
        #semana=%w[lunes martes miercoles jueves viernes sabado domingo]
        #appointments=Appointment.by_day(week[0]).or()
        if professional.nil?
          appointments=Appointment.by_day( week[0]).or(Appointment.by_day(week[1]).or(Appointment.by_day(week[2]).or(Appointment.by_day(week[3]).or(Appointment.by_day( week[4]).or(Appointment.by_day( week[5]))))))
        else
          appointments=Appointment.by_day_and_professional( week[0], self.professional).or(Appointment.by_day_and_professional( week[1], self.professional).or(Appointment.by_day_and_professional(week[2], self.professional).or(Appointment.by_day_and_professional( week[3], self.professional).or(Appointment.by_day_and_professional(week[4], self.professional).or(Appointment.by_day_and_professional(week[5], self.professional))))))
          #appointments=Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", week[0], self.professional).or(Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", week[1], self.professional).or(Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", week[2], self.professional).or(Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=? ", week[3], self.professional).or(Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", week[4], self.professional).or(Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", week[5], self.professional))))))
          
        end
        type="weekly"
        Grid.generating_grid(type,appointments, self.day,'app/templates/grids/weekly.html.erb','weekly_grid.html')
        #week=week.to_a
        
        #template = ERB.new (Rails.root.join('app/templates/grids/weekly.html.erb')).read
        
        
        #File.open( "#{Dir.home}/weekly_grid.html", "w+") do |f|
        #    f.write(template.result binding)
        #end
      end
end