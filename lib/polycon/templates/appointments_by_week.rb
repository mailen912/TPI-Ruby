require 'erb'
module Polycon
    module Templates
        module Appointments_by_week
            def export_my_appointments(appointments, schedule, week)
            
            semana=%w[lunes martes miercoles jueves viernes sabado]
            
            for  paciente in appointments.find_all{ |app| app.date.split(" ")[1]=="10:00"}
                puts paciente.name
            end
            
            template = ERB.new <<~END, nil, '-'
            <!DOCTYPE html>
            <html lang="en">
              <head>
                <title> Turnos </title>
                <meta charset="UTF-8">
              </head>
              <body>
                <table style="width:90%" border>
                  <tr>
                    <th> Hora/Dia</th>
                    <%- week.inject(0) do |i,w|  -%>
                        <th><%=w  %> <%= semana.pop %></th>
                    <%- end  -%>
                 
                  </tr>
            
                    <%- schedule.each do |hs| -%>
                      <tr>
                      <td><%= hs %></td>
                        <%- week.each do |w| -%>
                           <td >
        
                           <%- for paciente in appointments.find_all{ |app| app.date.split(" ")[1]==hs and app.date.split(" ")[0] == w} do -%>
                        
                   
                              <div><%=paciente.surname  %> 
                                <%= paciente.name %> (<%= paciente.professional %>)</div> 
                            <%- end -%></td>
                     
                        <%- end -%> </tr>
                    <%- end -%>
                
                    
                </table>
              </body>
            </html>
            END
            
            puts template.result binding
            File.open( "#{Dir.home}/grilla_diaria.html", "w+") do |f|
                f.write(template.result binding)
            end
            end
            
            

        end
    end
end