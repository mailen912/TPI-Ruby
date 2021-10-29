require 'erb'
module Polycon
    module Templates
        module Appointments_by_day
            def export_my_appointments(appointments, schedule, day)
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
                <table style="width:30%" border=1>
                  <tr>
                    <th> Hora/Dia</th>
                  
                    <th><%= day %></th>
                 
                  </tr>
                  <%- schedule.each do |hs| -%>
                  <tr>
                 
                    <td><%= hs %></td>
                    <td >
                    <%- for paciente in appointments.find_all{ |app| app.date.split(" ")[1]==hs} do -%>
                        
                   
                            <div><%=paciente.surname  %> 
                            <%= paciente.name %> (<%= paciente.professional %>)</div> 
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
    end
end
