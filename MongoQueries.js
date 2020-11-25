// 1
db.films.find({'Rating': {$eq: 'PG'}}, {'Special Features': 1})
// 2
db.films.distinct('Length')
// 3
db.films.find({'Replacement Cost': {$gte: '20.00', $lte: '24.00'}}, {'Title': 1, 'Rental Duration': 1, 'Replacement Cost': 1})
// 4
db.films.find({'Special Features': {$eq: 'Behind the Scenes'}}, {'Title': 1, 'Rating': 1, 'Category': 1})
// 5
db.films.findOne({'Title': {$eq: 'ZOOLANDER FICTION'}}, {'Actors.First name': 1, 'Actors.Last name': 1})
// 6
db.stores.findOne({_id: 1}, {'Address': 1, 'City': 1, 'Country': 1})
// 7
db.films.aggregate(
  [
    { $group : { _id : "$Rating", films: { $push: "$Title" } } }
  ]
)
// 8
var availableFilms = []
var store = db.stores.findOne({_id: 2})
console.log(store)