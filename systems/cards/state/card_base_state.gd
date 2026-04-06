## Card State used for a card in the resting state 
##
class_name CardBaseState
extends CardState

var original_index: int = -1

## Enters the base state
##
func enter() -> void:
	
	if not card_ui.is_node_ready():
		await card_ui.ready
	
	#if card_ui.tween and card_ui.tween.is_running():
		#card_ui.tween.kill()
	
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	#card_ui.reparent_requested.emit(card_ui)
	card_ui.pivot_offset = Vector2.ZERO
	move_card_to_origin()
	#Events.tooltip_hide_requested.emit()

## Activates when a card had an input
##
func on_gui_input(event: InputEvent) -> void:
	if not card_ui.playable:
		return
	
	# If user left clicks card it moves based on where the card was clicked and moves to the clicked state
	if event is InputEventMouseButton and event.is_action_pressed("left_click") and event.pressed:
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.CardState.CLICKED)

## Used for when the mouse hovers over a card
##
func on_mouse_entered() -> void:
	if not card_ui.playable:
		return
		
	var card_ui := owner as CardUI
	var hand := card_ui.get_parent()
	original_index = hand.get_children().find(card_ui)

	hand.move_child(card_ui, hand.get_child_count() - 1)

	# Changes card to card ui's hover style and creates tooltip for card
	card_ui.panel.set("theme_override_styles/panel", card_ui.HOVER_STYLE_BOX)
	card_ui.scale = Vector2(card_ui.scale.x + .05, card_ui.scale.x + .05)
	#Events.card_tooltip_requested.emit(card_ui.card.icon, card_ui.card.tooltip_text)

## Used for when the mouse leaves from hovering the card
##
func on_mouse_exited() -> void:
	#if not card_ui.playable or card_ui.disabled:
		#return
	#if original_index >= 0:
	move_card_to_origin()
	# Goes back to non hover card ui style and hides tooltip
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	card_ui.scale = Vector2(card_ui.scale.x - .05, card_ui.scale.x - .05)
	#Events.tooltip_hide_requested.emit()

func move_card_to_origin() -> void:
	var card_ui := owner as CardUI
	#card_ui.scale = Vector2(card_ui.scale.x + .05, card_ui.scale.x + .05)
	#if card_ui.scale.x > 0.8 && card_ui.scale.x < 1.2 && card_ui.scale.y > 0.8 && card_ui.scale.y < 1.2:
		#card_ui.scale = Vector2(card_ui.scale.x - .05, card_ui.scale.x - .05)
	var hand := card_ui.get_parent()
	hand.move_child(card_ui, original_index)
