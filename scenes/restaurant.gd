extends Node2D

signal burger_sold_to_customer
signal assembly_space_lettuce_full
signal assembly_area_patty_full
signal assembly_area_bun_full
signal cutting_board_full
signal cooking_area_full
signal assembly_area_cheese_full
signal burger_build_bad

export(PackedScene) var burger_patty_scene
export(PackedScene) var burger_bun_scene
export(PackedScene) var lettuce_head_scene
export(PackedScene) var cheese_scene

export var money = 0
var patty_used_count = 0
var bun_used_count = 0
var lettuce_used_count = 0
var cheese_used_count = 0

#add burger value
# how to grade a burger, use the temp with what the request is?
# build a customer requesting a burger


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_action_menu_add_burger_patty():
	print("add burger clicked")
	cook_burger_patty()

func _on_action_menu_add_lettuce():
	print("add lettuce clicked")
	chop_lettuce_head()

func _on_action_menu_remove_lettuce():
	print("remove lettuce clicked")
	remove_lettuce_head()

func _on_action_menu_get_burger_bun():
	print("adding burger bun clicked")
	add_burger_bun()

func _on_action_menu_build_burger():
	print("building burger clicked")
	build_burger()

func cook_burger_patty():
	if $cooking_area.cooking_space < $cooking_area.cooking_space_max:
		print("cooking burger")
		patty_used_count += 1
		$PattiesUsedLabel.text = str("Patties Used: ", patty_used_count)
		var patty = burger_patty_scene.instance()
		$cooking_area.add_patty_to_cook(patty)
	else:
		print("full grill, can't cook patty")
		emit_signal("cooking_area_full")

func remove_burger_patty_1():
	if $cooking_area.cooking_spot_1 != null && !$assembly_area.has_patty:
		print("removing burger from spot 1")
		var cooked_patty = $cooking_area.remove_patty_1()
		$assembly_area.add_cooked_patty(cooked_patty)
	else:
		if $assembly_area.has_patty:
			emit_signal("assembly_area_patty_full")
		else:
			print("nothing to remove")

func remove_burger_patty_2():
	if $cooking_area.cooking_spot_2 != null && !$assembly_area.has_patty:
		print("removing burger from spot 2")
		var cooked_patty = $cooking_area.remove_patty_2()
		$assembly_area.add_cooked_patty(cooked_patty)
	else:
		if $assembly_area.has_patty:
			emit_signal("assembly_area_patty_full")
		else:
			print("nothing to remove")
		
func remove_burger_patty_3():
	if $cooking_area.cooking_spot_3 != null && !$assembly_area.has_patty:
		print("removing burger from spot 3")
		var cooked_patty = $cooking_area.remove_patty_3()
		$assembly_area.add_cooked_patty(cooked_patty)
	else:
		if $assembly_area.has_patty:
			emit_signal("assembly_area_patty_full")
		else:
			print("nothing to remove")
		
func remove_burger_patty_4():
	if $cooking_area.cooking_spot_4 != null && !$assembly_area.has_patty:
		print("removing burger from spot 4")
		var cooked_patty = $cooking_area.remove_patty_4()
		$assembly_area.add_cooked_patty(cooked_patty)
	else:
		if $assembly_area.has_patty:
			emit_signal("assembly_area_patty_full")
		else:
			print("nothing to remove")

func add_burger_bun():
	if !$assembly_area.has_bun:
		bun_used_count += 1
		$BunsUsedLabel.text = str("Buns Used: ", bun_used_count)
		var bun = burger_bun_scene.instance()
		$assembly_area.add_burger_bun(bun)
	else:
		print("assembly space already has a bun")
		emit_signal("assembly_area_bun_full")

func get_cheese():
	if !$assembly_area.has_cheese:
		cheese_used_count += 1
		$CheeseUsedLabel.text = str("Cheese Used: ", cheese_used_count)
		var cheese = cheese_scene.instance()
		$assembly_area.add_cheese(cheese)
	else:
		print("assembly space already has cheese")
		emit_signal("assembly_area_cheese_full")

func chop_lettuce_head():
	if $cutting_area.board_space < $cutting_area.board_space_max:
		print("cutting lettuce")
		lettuce_used_count += 1
		$LettuceUsedLabel.text = str("Lettuce Used: ", lettuce_used_count)
		var lettuce = lettuce_head_scene.instance()
		$cutting_area.add_lettuce_to_cut(lettuce)
	else:
		print("full cutting board, can't chop lettuce")
		emit_signal("cutting_board_full")

func remove_lettuce_head():
	if $cutting_area.chopping_items[0] != null:
		print("removing lettuce")
		var lettuce = $cutting_area.remove_first_lettuce()
		if lettuce != null && !$assembly_area.has_lettuce:
			$assembly_area.add_chopped_lettuce(lettuce)
		else:
			print("assembly space already has lettuce")
			emit_signal("assembly_space_lettuce_full")

func build_burger():
	$assembly_area.build_burger()

func _on_assembly_area_burger_sold(burger_order):
	# currently, if there is no customer than the burger is thrown away
	print("burger successfully sold to customer")
	emit_signal("burger_sold_to_customer", burger_order)

func _on_Main_award_money(money_value):
	print("money received from customer: ", money_value)
	money += money_value
	$MoneyLabel.text = str("MONEY: ", money)

func clear_used_counts():
	patty_used_count = 0
	bun_used_count = 0
	lettuce_used_count = 0
	cheese_used_count = 0
	$PattiesUsedLabel.text = str("Patties Used: ", patty_used_count)
	$BunsUsedLabel.text = str("Buns Used: ", bun_used_count)
	$CheeseUsedLabel.text = str("Cheese Used: ", cheese_used_count)
	$LettuceUsedLabel.text = str("Lettuce Used: ", lettuce_used_count)

func clear_areas():
	$cutting_area.clear_cutting_board()
	$cooking_area.clear_cooking_area()
	$assembly_area.clear_assembly_area()


func _on_action_menu_remove_burger_patty_1():
	print("remove burger 1 clicked")
	remove_burger_patty_1()


func _on_action_menu_remove_burger_patty_2():
	print("remove burger 2 clicked")
	remove_burger_patty_2()


func _on_action_menu_remove_burger_patty_3():
	print("remove burger 3 clicked")
	remove_burger_patty_3()


func _on_action_menu_remove_burger_patty_4():
	print("remove burger 4 clicked")
	remove_burger_patty_4()


func _on_action_menu_get_cheese():
	print("get cheese clicked")
	get_cheese()


func _on_assembly_area_cant_build_burger():
	emit_signal("burger_build_bad")
