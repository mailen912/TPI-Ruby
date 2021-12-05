require 'date'
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
      num_resta = Integer(Date.parse(day).strftime("%u"))-1 
      monday = Date.parse(day) - num_resta
      week=[]
      week.push(monday.to_s)
      for d in (1..5)
          week.push((monday + d).to_s)
      end
      week
    end

    def export_daily
      schedule=Appointment.schedule
      if professional.nil?
        appointments=Appointment.where("strftime('%Y-%m-%d', date) = ?", self.day)
      else
        appointments=Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", self.day, self.professional )
      end
       template = ERB.new (Rails.root.join('app/templates/grids/daily.html.erb')).read
      
        File.open( "#{Dir.home}/daily_grid.html", "w+") do |f|
            f.write(template.result binding)
        end
      end

      def export_weekly
        schedule=Appointment.schedule
        week=Grid.get_week(self.day)            
        semana=%w[lunes martes miercoles jueves viernes sabado]
        if professional.nil?
          appointments=Appointment.where("strftime('%Y-%m-%d', date) = ?", week[0]).or(Appointment.where("strftime('%Y-%m-%d', date) = ?", week[1]).or(Appointment.where("strftime('%Y-%m-%d', date) = ?", week[2]).or(Appointment.where("strftime('%Y-%m-%d', date) = ?", week[3]).or(Appointment.where("strftime('%Y-%m-%d', date) = ?", week[4]).or(Appointment.where("strftime('%Y-%m-%d', date) = ?", week[5]))))))
        else
          appointments=Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", week[0], self.professional).or(Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", week[1], self.professional).or(Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", week[2], self.professional).or(Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=? ", week[3], self.professional).or(Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", week[4], self.professional).or(Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", week[5], self.professional))))))
          
        end

        
        template = ERB.new (Rails.root.join('app/templates/grids/weekly.html.erb')).read
        
        
        File.open( "#{Dir.home}/weekly_grid.html", "w+") do |f|
            f.write(template.result binding)
        end
      end
end