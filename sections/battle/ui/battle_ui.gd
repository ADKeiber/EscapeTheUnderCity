class_name BattleUI
extends CanvasLayer

@onready var hand:= %Hand

const CARD_UI = preload("res://main/card_ui/card_ui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.card_anchors_ready.connect(init_cards) # sets cards to anchors

func init_cards() -> void:
	var card_anchors := State.player_stats.card_anchors
	State.player_stats.sort_card_anchors_desc()
	for anchor in card_anchors:
		var card: Card
		if anchor.resource_type == Card.TimeResource.HUMAN:
			card = State.player_stats.human_draw_pile.draw_card()
			State.player_stats.current_hand.add_card(card)
		if anchor.resource_type == Card.TimeResource.AI:
			card = State.player_stats.ai_draw_pile.draw_card()
			State.player_stats.current_hand.add_card(card)
		anchor.card = card
		var new_card_ui := CARD_UI.instantiate()
		hand.add_child(new_card_ui)
		new_card_ui.set_anchors_preset(Control.PRESET_TOP_LEFT)
		new_card_ui.anchor = anchor
		new_card_ui.card = anchor.card
		new_card_ui.global_position = anchor.position
		new_card_ui.scale = Vector2(.45,.45)
	
	print("INIT CARDS")
