extends Node2D

signal eod_summary_continue

func _on_ConfirmButton_pressed():
	emit_signal("eod_summary_continue")

func update_patty_label(patty_text):
	$EodSummary/PattiesUsedLabel.text = patty_text

func update_bun_label(bun_text):
	$EodSummary/BunsUsedLabel.text = bun_text

func update_lettuce_label(lettuce_text):
	$EodSummary/LettuceUsedLabel.text = lettuce_text

func update_grand_total_label(grand_total_text):
	$EodSummary/GrandTotalLabel.text = grand_total_text

func update_restaurant_label(money_text):
	$EodSummary/RestaurantMoneyLabel.text = money_text

func update_daily_earned_label(daily_text):
	$EodSummary/DailyEarnedMoneyLabel.text = daily_text

func update_eow_label(eow_text):
	$EodSummary/EOWCountDownLabel.text = eow_text

func show_rent_label(rent_text):
	$EodSummary/RentLabel.visible = true
	$EodSummary/RentLabel.text = rent_text
