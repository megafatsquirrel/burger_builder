extends Node2D

signal burger_sold
signal cant_build_burger

var assembly_cooked_patty = null
var assembly_bun = null
var assembly_chopped_lettuce = null
var assembly_cheese = null

var has_patty = false
var has_bun = false
var has_lettuce = false
var has_cheese = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Build a spot for each burger component

func add_cooked_patty(cooked_patty):
	print("add cooked patty to assembly area")
	assembly_cooked_patty = cooked_patty
	add_child(assembly_cooked_patty)
	has_patty = true

func add_burger_bun(bun):
	print("add burger bun to assembly area")
	assembly_bun = bun
	assembly_bun.position.x = 150
	assembly_bun.position.y = 50
	add_child(assembly_bun)
	has_bun = true
	
func add_cheese(cheese):
	print("add cheese to assembly area")
	assembly_cheese = cheese
	assembly_cheese.position.x = 250
	assembly_cheese.position.y = 50
	add_child(assembly_cheese)
	has_cheese = true

func add_chopped_lettuce(chopped_lettuce):
	print("add chopped lettuce to assembly area")
	assembly_chopped_lettuce = chopped_lettuce
	assembly_chopped_lettuce.position.x = 350
	assembly_chopped_lettuce.position.y = 50
	add_child(assembly_chopped_lettuce)
	has_lettuce = true

func build_burger():
	if can_build_burger():
		var built_patty = assembly_cooked_patty
		var built_bun = assembly_bun
		var built_lettuce = assembly_chopped_lettuce
		var built_cheese = assembly_cheese
		var burger_order = [built_patty, built_bun, built_lettuce, built_cheese]
		print("burger built and sold")
		emit_signal("burger_sold", burger_order)
		remove_child(assembly_cooked_patty)
		remove_child(assembly_bun)
		if has_lettuce:
			remove_child(assembly_chopped_lettuce)
		if has_cheese:
			remove_child(assembly_cheese)
		has_patty = false
		has_bun = false
		has_lettuce = false
		has_cheese = false
		assembly_cooked_patty = null
		assembly_bun = null
		assembly_chopped_lettuce = null
		assembly_cheese = null
	else:
		print("missing burger parts, can't build burger")
		emit_signal("cant_build_burger")

func can_build_burger():
	# every order at a minimum needs a patty and a bun
	var can_build = false
	if has_patty && has_bun:
		can_build = true
	return can_build

func clear_assembly_area():
	if assembly_cooked_patty != null:
		remove_child(assembly_cooked_patty)
	if assembly_bun != null:
		remove_child(assembly_bun)
	if has_lettuce:
		remove_child(assembly_chopped_lettuce)
	if has_cheese:
		remove_child(assembly_cheese)
	has_patty = false
	has_bun = false
	has_lettuce = false
	has_cheese = false
	assembly_cooked_patty = null
	assembly_bun = null
	assembly_chopped_lettuce = null
	assembly_cheese = null
