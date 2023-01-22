extends Node2D

var burger_request = ["I want a hamburger.", "I want a hamburger with lettuce", "I want a cheese burger"]
var selected_request = null
var rand_num = null

var customer_feedback_raw = ["This isn't cooked!!!", "Are you trying to poison me?!", "I'm telling the health food inspector about this!", "....I was really looking forward to this today..."]
var customer_feedback_good = ["This is great!", "Looks yummy.", "Smells like winning!", "I can't wait to eat it."]
var customer_feedback_neutral = ["Uh, I thought I order something else.", "I guess this works.", "I'm not tipping!", "Are you ok?", "Maybe you need a break?"]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	rand_num = randi() % burger_request.size()      # Returns random integer between 0 and 1
	selected_request = burger_request[rand_num]
	$CustomerRequestLabel.text = str(selected_request)

func _on_Timer_timeout():
	$CustomerRequestLabel.visible = false
	$Sprite.visible = false

func get_bad_feedback():
	var rando = randi() % customer_feedback_raw.size()
	$CustomerRequestLabel.text = str(customer_feedback_raw[rando])
	$CustomerRequestLabel.visible = true
	$Sprite.visible = true
	$HideCustomerRequestTimer.start()

func get_good_feedback():
	var rando = randi() % customer_feedback_good.size()
	$CustomerRequestLabel.text = str(customer_feedback_good[rando])
	$CustomerRequestLabel.visible = true
	$Sprite.visible = true
	$HideCustomerRequestTimer.start()

func get_neutral_feedback():
	var rando = randi() % customer_feedback_neutral.size()
	$CustomerRequestLabel.text = str(customer_feedback_neutral[rando])
	$CustomerRequestLabel.visible = true
	$Sprite.visible = true
	$HideCustomerRequestTimer.start()
