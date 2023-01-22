extends Node2D


# Controls the cooking temp and how the burgers are going to be cooked
export var cooking_temp = 500
# Controls the capacity
export var cooking_space = 0
export var cooking_space_max = 4

var cooking_spot_1 = null;
var cooking_spot_2 = null;
var cooking_spot_3 = null;
var cooking_spot_4 = null;

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooking_spot_1 != null:
		cooking_spot_1.cook()
		
	if cooking_spot_2 != null:
		cooking_spot_2.cook()
		
	if cooking_spot_3 != null:
		cooking_spot_3.cook()
		
	if cooking_spot_4 != null:
		cooking_spot_4.cook()

func add_patty_to_cook(patty):
	#find first open spot
	
	if cooking_spot_1 == null:
		cooking_spot_1 = patty
		cooking_space += 1
		patty.position.x = 50
		patty.position.y = 50
	elif cooking_spot_2 == null:
		cooking_spot_2 = patty
		cooking_space += 1
		patty.position.x = 150
		patty.position.y = 50
	elif cooking_spot_3 == null:
		cooking_spot_3 = patty
		cooking_space += 1
		patty.position.x = 250
		patty.position.y = 50
	elif cooking_spot_4 == null:
		cooking_spot_4 = patty
		cooking_space += 1
		patty.position.x = 350
		patty.position.y = 50
	else:
		print("no open spots, but that should be prevented by restaurant")
	add_child(patty)
	

func remove_patty_1():
	# i need to know which patty is getting removed
	# remove the patty and move to assembly area
	cooking_space -= 1
	var patty = cooking_spot_1
	patty.position.x = 50
	cooking_spot_1 = null
	remove_child(patty)
	return patty

func remove_patty_2():
	# i need to know which patty is getting removed
	# remove the patty and move to assembly area
	cooking_space -= 1
	var patty = cooking_spot_2
	patty.position.x = 50
	cooking_spot_2 = null
	remove_child(patty)
	return patty

func remove_patty_3():
	# i need to know which patty is getting removed
	# remove the patty and move to assembly area
	cooking_space -= 1
	var patty = cooking_spot_3
	patty.position.x = 50
	cooking_spot_3 = null
	remove_child(patty)
	return patty

func remove_patty_4():
	# i need to know which patty is getting removed
	# remove the patty and move to assembly area
	cooking_space -= 1
	var patty = cooking_spot_4
	patty.position.x = 50
	cooking_spot_4 = null
	remove_child(patty)
	return patty

func clear_cooking_area():
	cooking_space = 0
	if cooking_spot_1 != null:
		remove_child(cooking_spot_1)
		cooking_spot_1 = null
		
	if cooking_spot_2 != null:
		remove_child(cooking_spot_2)
		cooking_spot_2 = null
		
	if cooking_spot_3 != null:
		remove_child(cooking_spot_3)
		cooking_spot_3 = null
		
	if cooking_spot_4 != null:
		remove_child(cooking_spot_4)
		cooking_spot_4 = null

