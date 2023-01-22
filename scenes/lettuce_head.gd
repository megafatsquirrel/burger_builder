extends Node2D

export var is_chopped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = "default"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	is_chopped = true
	$Label.text = str("Chopping done")
	$AnimatedSprite.animation = "chopped"
