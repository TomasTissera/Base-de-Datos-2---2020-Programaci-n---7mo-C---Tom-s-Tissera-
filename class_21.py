import redis
from datetime import date
r = redis.Redis(host='localhost', port=6000)
print("Bienvenido a tu sistema de guardado de Gastos")
gasto = 'a'
today = str(date.today())
fecha = 'a'
while gasto != "":
    gasto = input("Inserte su Gasto mas reciente o presione enter para salir ")
    if gasto == "":
        pass
    else:
        r.lpush(today, gasto)
print('Los Gastos del dia ' + today+' fueron:')
for a in r.lrange(today, 0, -1):
    print(str(a.decode('utf-8')))
print('Estas son todas las fechas que en las que se guardaron Gastos: ')
for key in r.scan_iter():
    print(str(key.decode('utf-8')))
while fecha != '':
    fecha = input(
        'Inserte la fecha de la que desea saber que Gasto o presione enter para salir ')
    for x in r.lrange(fecha, 0, -1):
        print(str(x.decode('utf-8')))
