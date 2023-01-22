extends Node2D

signal brunt_patty_remove

export var temp = -32 #Assuming frozen patties

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func cook():
	temp += 1
	$Label.text = str(temp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if temp > 120 && temp < 160:
		#print("burger cooked rare - well done")
		$AnimatedSprite.self_modulate = Color(0.4, 0, 0) # green shade, children not affected
	elif temp > 180:
		#print("burger is brunt")
		$AnimatedSprite.self_modulate = Color(0, 0, 0)
	#if temp > 200:
	#	brunt_patty_remove()

func brunt_patty_remove():
	emit_signal("brunt_patty_remove")
	#queue_free()
