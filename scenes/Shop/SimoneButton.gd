extends Button

var dumb_counter = 0 setget set_dumb_counter
onready var player_id = get_tree().get_network_unique_id() 

func set_dumb_counter(new_value):
	dumb_counter = new_value
	if dumb_counter < 5 : 
		set_text("En voiture Simone ! (ouais enfin quand on saura où on va...)")
		print("Faut choisir un path !")
	else :
		set_text("T'es con ou quoi ?! Choisis un putain de chemin d'abord !!!")
