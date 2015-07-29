json.id movie.id
json.title movie.title
json.year movie.year
json.rating movie.rating
json.roles movie.roles do |role|
	json.id role.id
	json.name role.name
	json.actor_id role.actor.id
	json.actor_name role.actor.name
end