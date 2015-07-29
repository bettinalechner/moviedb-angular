json.id actor.id
json.name actor.name
json.firstName actor.first_name
json.lastName actor.last_name
json.dateOfBirth actor.date_of_birth
json.age actor.age
json.roles actor.roles do |role|
	json.id role.id
	json.name role.name
	json.movie_id role.movie.id
	json.movie_title role.movie.title
end