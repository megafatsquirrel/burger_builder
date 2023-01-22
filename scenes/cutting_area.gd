extends Node2D


# Contains the information of what is on the board
# Controls the capacity
export var board_space = 0
export var board_space_max = 1

var chopping_items = [null]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_lettuce_to_cut(lettuce_head):
	board_space += 1
	add_child(lettuce_head)
	chopping_items.insert(0, lettuce_head)

func remove_first_lettuce():
	if chopping_items[0].is_chopped:
		var lettuce = chopping_items[0]
		board_space -= 1
		remove_child(lettuce)
		chopping_items.remove(0)
		return lettuce
	else:
		print("Still chopping lettuce")
		return null

func clear_cutting_board():
	if chopping_items[0] != null:
		var lettuce = chopping_items[0]
		board_space -= 1
		remove_child(lettuce)
		chopping_items.remove(0)
	
