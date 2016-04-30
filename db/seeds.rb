# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

food_categories = [

	'American',
	'Chineese',
	'Greek',
	'Indian',
	'Italian',
	'Japanese',
	'Mediterranean',
	'Mexican',
	'SeaFood',
	'Steakhouse',
	'Sushi'

]

bar_categories = [

	'Craft Selection',
	'Cigar Bar',
	'College',
	'Cocktail Lounge',
	'Live Music',
	'Nightclub',
	'Pub',
	'Sports Bar',
	'Wine Bar'

]

attend_categories = [

	'Live Music',
	'Charity',
	'Comedy',
	'Festival',
	'Sporting',
	'Social',
	'Theater',
	'Arts & Fashion'

]

features = [

	'Dance Floor',
	'Darts',
	'Handicap access',
	'Late Nite Menu',
	'Live Music',
	'Outdoor Seating',
	'Pool Table',
	'Six packs to go',
	'Smoking Section',
	'Valet Parking',
	'Wifi'

]

Category.destroy_all 
food_categories.each do |name|
	Category.create!(name: name, sort: 'eat')
end

bar_categories.each do |name|
	Category.create!(name: name, sort: 'drink')
end

attend_categories.each do |name|
	Category.create(name: name, sort: 'attend')
end

Feature.destroy_all 
features.each do |name|
	Feature.create(name: name)
end

