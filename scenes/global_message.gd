extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_message(text):
	if $Timer.is_stopped():
		$Label.text = str(text)
		$Label.visible = true
		$Sprite.visible = true
		$Timer.start()
	else:
		print("Global message in use!")

func _on_Timer_timeout():
	$Label.visible = false
	$Sprite.visible = false
