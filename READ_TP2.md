Solo se pueden crear turnos para los dias lunes, martes, miercoles, jueves, viernes y sabado; en los minutos en 00 o 30 y, a partir de las 10 hasta las 20:30.
La grilla mostrará la información en bloques de duración fija (cada 30 minutos), y cada turno se considera como que durará el total de tiempo del bloque en el que esta.
Los turnos de un/a mismo/a profesional no se solaparán dentro de un mismo bloque (no hay sobreturnos). Esto no es válido para turnos de distintos/as profesionales.
Para obtener la grilla de una determinada semana se ingresa un dia x y se muestra la semana en la que se encuentra ese dia.
Las grillas se exportan al directorio home del usuario y se sobreescriben si ya fue solicitada esa instruccion, sin importar que los datos sean distintos. No me parecio relevante guardarlos por separado
Cuando se exportan los turnos en un día particular, opcionalmente filtrando por un o una profesional; se obtiene o sobreescribe la grilla "grilla_dia"
Cuando se exportan los turnos en un semana particular, opcionalmente filtrando por un o una profesional; se obtiene o sobreescribe la grilla "grilla_diaria"
Las grillas que se generan son en formato html basicamente porque fue lo que me parecio mas facil manejar, ya que tengo algo de conocimiento y me daba mas seguridad. Lo probe, me funciono, lo entendi y por eso lo use.
Por ultimo, decir que arregle lo que se me pidio en la devolucion de la entrega 1 y complete el metodo que me faltaba 