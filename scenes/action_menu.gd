extends Node2D

signal add_burger_patty
signal remove_burger_patty_1
signal remove_burger_patty_2
signal remove_burger_patty_3
signal remove_burger_patty_4
signal add_lettuce
signal remove_lettuce
signal get_burger_bun
signal build_burger
signal get_cheese

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	emit_signal("add_burger_patty")

func _on_Button2_pressed():
	emit_signal("remove_burger_patty_1")

func _on_Button7_pressed():
	emit_signal("remove_burger_patty_2")

func _on_Button8_pressed():
	emit_signal("remove_burger_patty_3")

func _on_Button9_pressed():
	emit_signal("remove_burger_patty_4")

func _on_Button5_pressed():
	emit_signal("get_burger_bun")

func _on_Button6_pressed():
	emit_signal("build_burger")

func _on_Button3_pressed():
	emit_signal("add_lettuce")

func _on_Button4_pressed():
	emit_signal("remove_lettuce")


func _on_Button10_pressed():
	emit_signal("get_cheese")
