require 'erb'
module Polycon
    module Templates
        module Appointments_by_day
            def method(appointments) #en vez de esto habria un metodo que recibiria los turnos par hacer el html
                x = 42
                template = ERB.new <<-EOF
                The value of x is: <%= x %> ACAAA
                EOF
                puts template.result(binding)
            end

        end
    end
end
