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

    def export_daily
      schedule=Appointment.schedule
      if professional.nil?
        appointments=Appointment.where("strftime('%Y-%m-%d', date) = ?", self.day)
      else
        appointments=Appointment.where("strftime('%Y-%m-%d', date) = ? and professional_id=?", self.day, self.professional )
      end
      for paciente in appointments.find_all{ |app| app.date.strftime("%H:%M")=="10:00"} do 
        puts paciente.surname  
        puts paciente.name
        puts paciente.professional.name 
       end 
       template = ERB.new <<~END, nil, '-'
            <!DOCTYPE html>
            <html lang="en">
              <head>
                <title> Turnos </title>
                <meta charset="UTF-8">
              </head>
              <body>
                <table style="width:30%" border=1>
                  <tr>
                    <th> Hora/Dia</th>
                  
                    <th><%= day %></th>
                 
                  </tr>
                  <%- schedule.each do |hs| -%>
                  <tr>
                 
                    <td><%= hs %></td>
                    <td >
                    <%- for paciente in appointments.find_all{ |app| app.date.strftime("%H:%M")==hs} do -%>
                        
                   
                            <div><%=paciente.surname  %> 
                            <%= paciente.name %> (<%= paciente.professional.name %>)</div> 
                     <%- end -%>
                     </td>
                     </tr>
                <%- end -%>
                </table>
              </body>
            </html>
            END
        
        
        puts template.result binding
        File.open( "#{Dir.home}/grilla_dia.html", "w+") do |f|
            f.write(template.result binding)
        end
        end
end