## Card State used after a card has been clicked and its being dragged
##
class_name CardDraggingState
extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.05

var minimum_drag_time_elapsed := false

## Activated when entering the Dragging state
##
func enter() -> void:
	#card_ui.targets.clear()
	#var ui_layer := get_tree().get_first_node_in_group("ui_layer") # First node should be battle_ui
	#if ui_layer: # if it can't find the ui_layer it adds card_ui to the UI layer
		#card_ui.reparent(ui_layer)
	
	card_ui.panel.set("theme_override_styles/panel", card_ui.DRAGGING_STYLEBOX) # Changes card to drag style
	#Events.card_drag_started.emit(card_ui)
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)
	

## Activated when leaving the Dragging state
##
func exit() -> void:
	card_ui.mouse_filter = Control.MOUSE_FILTER_STOP
	pass
	#Events.card_drag_ended.emit(card_ui)

## Activated when there is an input during the dragging state
##
func on_gui_input(event: InputEvent) -> void:
	var single_targeted := card_ui.card.is_single_targeted()
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_click")
	var confirm = event.is_action_released("left_click") or event.is_action_pressed("left_click")
	
	# moves to aiming state if single target and mouse motion
	if single_targeted and mouse_motion and card_ui.targets.size() > 0:
		transition_requested.emit(self, CardState.CardState.AIMING)
		return
	
	# when mouse moving keep card on the mouse at the point of where the card was clicked
	if mouse_motion == true:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	
	# if Dragging and right clicked card goes to base state
	if cancel == true:
		#card_ui.global_position = card_ui.drag_start_position
		#var card_ui := owner as CardUI
		#card_ui.move_card_to_origin()
		card_ui.animate_to_position(card_ui.anchor.position, 0.4)
		transition_requested.emit(self, CardState.CardState.BASE)
		
	
	# Goes to released state if min time elapsed and left mouse is released or pressed it goes to released state
	elif minimum_drag_time_elapsed and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.CardState.RELEASED)

func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset

	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		transition_requested.emit(self, CardState.CardState.RELEASED)
