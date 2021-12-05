Solo se pueden crear turnos para los dias lunes, martes, miercoles, jueves, viernes y sabado; en los minutos en 00 o 30 y, a partir de las 10 hasta las 20:30.
La grilla mostrará la información en bloques de duración fija (cada 30 minutos), y cada turno se considera como que durará el total de tiempo del bloque en el que esta.
Los turnos de un/a mismo/a profesional no se solaparán dentro de un mismo bloque (no hay sobreturnos). Esto no es válido para turnos de distintos/as profesionales.
Para obtener la grilla de una determinada semana se ingresa un dia x y se muestra la semana en la que se encuentra ese dia.
Las grillas se exportan al directorio home del usuario y se sobreescriben si ya fue solicitada esa instruccion, sin importar que los datos sean distintos. No me parecio relevante guardarlos por separado
Cuando se exportan los turnos en un día particular, opcionalmente filtrando por un o una profesional; se obtiene o sobreescribe la grilla "daily_grid"
Cuando se exportan los turnos en un semana particular, opcionalmente filtrando por un o una profesional; se obtiene o sobreescribe la grilla "weekly_grid"
La aplicacion esta en ingles por simplicidad y asi llegar a tiempo con la entrega. 
Para esta entrega se pidio manejo de usuarios. Dado que las personas no autenticadas no podrán acceder a ningún dato del sistema; el set de datos inicial es: 'admin@gmail.com', password: '123456' para el rol administrador; email: 'asistencia@gmail.com', password: '123456', para el rol asistencia; y email: 'consulta@gmail.com', password: '123456'para el rol consulta
Los administradores son los unicos que  pueden gestionar a los usuarios, y pueden si lo desean, eliminarse a si mismos.
Para levantar la aplicacion rails, primero se debe entrar al directorio consultorio(cd consultorio) y luego ingresar rails server
La creacion de usuarios no funciona