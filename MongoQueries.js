// 1 Mostrar título y características especiales de películas que son PG-13
db.films.find({ 'Rating': { $eq: 'PG' } }, { 'Special Features': 1 })
// 2 Obtenga una lista de todas las diferentes películas que duran.
db.films.distinct('Length')
// 3 Muestra el título, la tarifa de alquiler y el costo de reemplazo de las películas que tienen un costo de reemplazo de 20.00 a 24.00
db.films.find({ 'Replacement Cost': { $gte: '20.00', $lte: '24.00' } }, { 'Title': 1, 'Rental Duration': 1, 'Replacement Cost': 1 })
// 4 Muestra el título, la categoría y la calificación de las películas que tienen 'Detrás de escena' como características especiales.
db.films.find({ 'Special Features': { $eq: 'Behind the Scenes' } }, { 'Title': 1, 'Rating': 1, 'Category': 1 })
// 5 Muestra el nombre y apellido de los actores que actuaron en 'ZOOLANDER FICTION'
db.films.findOne({ 'Title': { $eq: 'ZOOLANDER FICTION' } }, { 'Actors.First name': 1, 'Actors.Last name': 1 })
// 6 Muestra la dirección, ciudad y país de la tienda con id 1
db.stores.findOne({ _id: 1 }, { 'Address': 1, 'City': 1, 'Country': 1 })
// 7 Muestra un par de títulos de películas y la clasificación de películas que tienen la misma clasificación.
db.films.aggregate(
  [
    { $group: { _id: "$Rating", films: { $push: "$Title" } } }
  ]
)
// 8 Obtenga todas las películas que están disponibles en la identificación de la tienda 2 y 
// el nombre / apellido del administrador de esta tienda (el administrador aparecerá en todas las filas).
var availableFilms = []
var store = db.stores.findOne({ _id: 2 })
console.log(store)