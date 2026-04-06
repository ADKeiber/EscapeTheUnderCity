## Card State used for picking a target for a card
##
class_name CardAimingState
extends CardState

const MOUSE_Y_SNAPBACK_THRESHOLD := 138     ## Pixel threshold for card to snap to middle of deck and start aiming

## Enters the aiming state
##
func enter() -> void:
	card_ui.targets.clear()
	#var offset := Vector2(get_viewport().get_visible_rect().size.x / 2, / 2)
	card_ui.animate_to_position(Vector2(card_ui.anchor.position.x,card_ui.anchor.position.y - 60), 0.35)
	card_ui.drop_point_detector.monitoring = false
	Signals.card_aim_started.emit(card_ui)

## Ends the card aiming state
##
func exit() -> void:
	Signals.card_aim_ended.emit(card_ui)
	var card_ui := owner as CardUI
	card_ui.scale = Vector2(.45,.45)

### Accounts for input during the card aiming process 
###
#func on_gui_input(event: InputEvent) -> void:
	#var mouse_motion := event is InputEventMouseMotion
	#var mouse_at_bottom := card_ui.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THRESHOLD
	#
	##Card goes back to returns to base state
	#if  event.is_action_pressed("right_click"):
		#transition_requested.emit(self, CardState.CardState.BASE)
		## If left mouse is released or pressed again the Card state goes to released state
	#elif event.is_action_released("left_click") or event.is_action_pressed("left_click"):
		#get_viewport().set_input_as_handled()
		#transition_requested.emit(self, CardState.CardState.RELEASED)

func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var mouse_at_bottom := card_ui.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THRESHOLD
	
	#Card goes back to returns to base state
	if  event.is_action_pressed("right_click"):
		card_ui.animate_to_position(card_ui.anchor.position, .4)
		transition_requested.emit(self, CardState.CardState.BASE) #TODO return to anchor
		
		# If left mouse is released or pressed again the Card state goes to released state
	elif event.is_action_released("left_click") or event.is_action_pressed("left_click"):
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.CardState.RELEASED)
