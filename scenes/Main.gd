extends Node

signal award_money

export(PackedScene) var intro_scene
export(PackedScene) var game_over_scene
export(PackedScene) var customer_scene
export(PackedScene) var EOD_summary_scene

var game_start = true

var has_active_customer = false
var current_customer = null
var current_request_text = null
var current_request_num = null

var health_violation_count = 0
var under_cooked_patty = false

var daily_customer_count = 0
var daily_customer_count_max = 2
var days_in_week = 7
var is_eow = false
var weeks_passed_count = 0

export var current_day = 0

var eod_summary = null
var intro = null
var game_over = null

#Expenses
export var weekly_rent = 1000
export var patty_cost = 2.00
export var bun_cost = 1.00
export var lettuce_cost = 1.50
export var daily_money_start = 0
export var daily_money_end = 0

func _ready():
	randomize()
	if game_start:
		intro = intro_scene.instance()
		add_child(intro)
		intro.get_node("Button").connect("pressed", self, "_on_intro_start_game")
		#wait to get game start signal


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CustomerTimer_timeout():
	if !has_active_customer:
		daily_customer_count += 1
		current_customer = customer_scene.instance()
		has_active_customer = true
		add_child(current_customer)
		current_request_text = current_customer.selected_request
		current_request_num = current_customer.rand_num
		#customer order on action menu
		$restaurant/action_menu/AnimatedSprite/Label6.text = str(current_request_text)

func _on_restaurant_burger_sold_to_customer(burger_order):
	if current_customer != null:
		$restaurant/action_menu/AnimatedSprite/Label6.text = str("")
		print("grading burger order against customer order")
		var quality_rating = check_burger_quality(burger_order)
		# take in the rating after and mutate the money award
		calculate_award_money(quality_rating)
		if quality_rating > 0:
			current_customer.get_good_feedback()
		elif quality_rating == 0:
			current_customer.get_neutral_feedback()
		elif quality_rating < 0:
			current_customer.get_bad_feedback()
		#wait for customer feedback 5 seconds
		$CustomerFeedbackTimer.start()
	else:
		print("No customer to give order to, throw away burger")
		$GlobalMsg.set_message("No customer waiting, burger has been discarded")

func check_burger_quality(burger_order):
	#at a minimum each order will have a patty and bun
	var patty = burger_order[0]
	#scoring marks
	var quality_points = 0
	if current_request_num == 0:
		print("grading regular hamburger")
		quality_points = check_patty_temp(patty)
	elif current_request_num == 1:
		print("grading regular hamburger with lettuce")
		quality_points = check_patty_temp(patty)
		if burger_order[2] == null:
			print("burger is missing lettuce")
			quality_points -= 50
	elif current_request_num == 2:
		print("grading cheese burger")
		quality_points = check_patty_temp(patty)
		if burger_order[3] == null:
			print("burger is missing cheese")
			quality_points -= 50
	print("quality_points: ", quality_points)
	return (quality_points)

func check_patty_temp(patty):
	var quality_points = 0
	print(str(patty.temp))
	if patty.temp < 145:
		print("patty is raw and under cooked")
		quality_points -= 100
		health_violation_count += 1
		under_cooked_patty = true
	elif patty.temp >= 145 && patty.temp < 160:
		print("patty is cooked perfect")
		quality_points += 2
	elif patty.temp >= 160 && patty.temp <= 180:
		print("patty is a little over cooked")
		quality_points += 1
	elif patty.temp >= 190:
		print("patty is burnt")
		quality_points -= 2
	return quality_points

func after_customer_clean_up():
	has_active_customer = false
	remove_child(current_customer)
	current_customer = null
	current_request_text = null
	current_request_num = null
	if daily_customer_count < daily_customer_count_max:
		$CustomerTimer.start()
	else:
		print("end the day, showing EOD summary")
		daily_money_end = $restaurant.money
		current_day += 1
		var add_rent = false
		if current_day == days_in_week:
			#add rent charge
			add_rent = true
			is_eow = true
		eod_summary = EOD_summary_scene.instance()
		# Track all the items used load data
		# pass in daily used components
		# pass in the cost of the components
		# if rent day pass that in too
		var patty_total = $restaurant.patty_used_count * patty_cost
		var bun_total = $restaurant.bun_used_count * bun_cost
		var lettuce_total = $restaurant.lettuce_used_count * lettuce_cost
		var patty_summary = str("PATTIES USED: ", $restaurant.patty_used_count,
		 " x $", patty_cost * 1.00, " = $", patty_total * 1.00)
		var bun_summary = str("BUNS USED: ", $restaurant.bun_used_count,
		 " x $", bun_cost * 1.00, " = $", bun_total * 1.00)
		var lettuce_summary = str("LETTUCE USED: ", $restaurant.lettuce_used_count,
		 " x $", lettuce_cost * 1.00, " = $", lettuce_total * 1.00)
		var expense_total = patty_total + bun_total + lettuce_total
		var grand_total = str("GRAND TOTAL: $", expense_total)
		var restaurant_money = str("RESTAURANT MONEY: $", $restaurant.money,
		 " - $", expense_total,  " = $",  ($restaurant.money - expense_total))
		var daily_earned = str("DAILY EARNED MONEY: $", daily_money_end - daily_money_start)
		var eow_text = str("Days left in week: ", days_in_week - current_day)
		var rent_text = str("RENT: $", weekly_rent, " - $", $restaurant.money, " = $", weekly_rent - $restaurant.money)
		eod_summary.update_patty_label(patty_summary)
		eod_summary.update_bun_label(bun_summary)
		eod_summary.update_lettuce_label(lettuce_summary)
		eod_summary.update_grand_total_label(grand_total)
		eod_summary.update_restaurant_label(restaurant_money)
		eod_summary.update_daily_earned_label(daily_earned)
		eod_summary.update_eow_label(eow_text)
		if add_rent:
			eod_summary.show_rent_label(rent_text)
		add_child(eod_summary)
		eod_summary.get_node("ConfirmButton").connect("pressed", self, "_on_EODSummary_eod_summary_continue")
		#Show cost of items used and minus the expense from restaurant money
		#  the extra expense of rent will be added
		$restaurant.money -= expense_total
		if is_eow:
			$restaurant.money -= weekly_rent
			#check game over
			if $restaurant.money < 0:
				print("Game Over, went negative on your restaurant money")
				game_over = game_over_scene.instance()
				add_child(game_over)
				game_over.get_node("Button").connect("pressed", self, "_on_game_over_play_again")


func calculate_award_money(quality_rating):
	# if the patty is raw or brunt the customer should refuse to pay and 
	# the player doesn't get paid and loses money on used ingredients
	var award_money = 100
	if quality_rating > 0:
		var percent_value = quality_rating / 100.00
		var new_reward = award_money * percent_value
		award_money += new_reward
		print("good burger, extra money: ", award_money)
	elif quality_rating < 0:
		quality_rating = 100 - abs(quality_rating)
		var percent_value = quality_rating / 100.00
		var new_reward = award_money * percent_value
		award_money = new_reward
		print("bad burger, lost some money: ", award_money)
	emit_signal("award_money", award_money)

func _on_EODSummary_eod_summary_continue():
	print("eod summary continue clicked")
	remove_child(eod_summary)
	eod_summary = null
	begin_new_day()
	
func _on_intro_start_game():
	print("start game clicked")
	remove_child(intro)
	intro = null
	game_start = false
	var rand_num = randi() % 4
	if rand_num == 0:
		rand_num += 1
	daily_customer_count_max = rand_num
	print("Customers for the day: ", daily_customer_count_max)
	$CustomerTimer.start()

func begin_new_day():
	$restaurant.clear_used_counts()
	$restaurant.clear_areas()
	daily_money_start = $restaurant.money
	if is_eow:
		current_day = 0
		is_eow = false
		weeks_passed_count += 1
	daily_customer_count = 0
	var rand_num = randi() % 4
	if rand_num == 0:
		rand_num += 1
	rand_num += weeks_passed_count
	daily_customer_count_max = rand_num
	print("Customers for the day: ", daily_customer_count_max)
	$CustomerTimer.start() 

func game_over_restart():
	remove_child(game_over)
	game_over = null
	# This happens quickly, a scene is needed
	current_customer = null
	current_request_text = null
	current_request_num = null
	is_eow = false
	current_day = 0
	$restaurant.money = 0
	weeks_passed_count = 0
	_on_EODSummary_eod_summary_continue()


func _on_CustomerFeedbackTimer_timeout():
	after_customer_clean_up()

func _on_game_over_play_again():
	game_over_restart()

func _on_restaurant_assembly_space_lettuce_full():
	$GlobalMsg.set_message("Assembly area already has lettuce.")


func _on_restaurant_assembly_area_patty_full():
	$GlobalMsg.set_message("Assembly area already has patty.")


func _on_restaurant_assembly_area_bun_full():
	$GlobalMsg.set_message("Assembly area already has bun.")


func _on_restaurant_cooking_area_full():
	$GlobalMsg.set_message("Cooking area is full.")


func _on_restaurant_cutting_board_full():
	$GlobalMsg.set_message("Cutting board is full.")


func _on_restaurant_assembly_area_cheese_full():
	$GlobalMsg.set_message("Assembly area already has cheese.")


func _on_restaurant_burger_build_bad():
	$GlobalMsg.set_message("Burger needs patty and bun to be built.")
