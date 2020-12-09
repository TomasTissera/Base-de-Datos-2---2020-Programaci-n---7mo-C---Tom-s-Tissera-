import redis

REDIS_PORT = 7000
REDIS_HOST = 'localhost'

r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, db=0)
a = True

while a:

    print('que quiere hacer? add/show/exit')
    res1 = input()

    if res1 == 'add':
        print("Ingrese nombre de la comida:")
        nombre = input()
        print("Ingrese el tipo de comida que es:")
        tipo = input()
        r.set(nombre, tipo)
    elif res1 == 'show':
        print("Todas las comidas:")
        print(r.keys())
    elif res1 == 'exit':
        a = False
    else:
        print('Ingrese opcion valida')
