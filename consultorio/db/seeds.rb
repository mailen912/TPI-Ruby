# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#usuarios para ingresar al sistema
User.create(email: 'admin@gmail.com', password: '123456', role:"administrator")
User.create(email: 'asistencia@gmail.com', password: '123456', role:"assistance")
User.create(email: 'consulta@gmail.com', password: '123456', role:"query")

#profesionales
p1=Professional.create(name:"Marina Baez")
p2=Professional.create(name:"Luciano Ramirez")
p3=Professional.create(name:"Alfonso Vazquez")
p4=Professional.create(name:"Lucia Lopetegui")

#turnos
Appointment.create(date:"2021-12-29 10:30", name:"Graciela", professional_id:p1.id, surname:"Perez", phone:"1123213")
Appointment.create(date:"2022-01-03 11:00", name:"Alberto", professional_id:p2.id, surname:"Garcia", phone:"1123213")
Appointment.create(date:"2022-01-03 10:30", name:"Lujan", professional_id:p2.id, surname:"LInares", phone:"1123213")
Appointment.create(date:"2021-12-29 10:30", name:"Pedro", professional_id:p3.id, surname:"Perez", phone:"1123213")
Appointment.create(date:"2021-12-29 12:30", name:"Lautaro", professional_id:p3.id, surname:"Carmona", phone:"1123213")
Appointment.create(date:"2022-01-03 10:30", name:"Martina", professional_id:p3.id, surname:"Giles", phone:"1123213")