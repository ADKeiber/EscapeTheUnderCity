## Card State used after a card has been clicked
##
class_name CardClickedState
extends CardState

## starts after clicked state began
##
func enter() -> void:
	card_ui.drop_point_detector.monitoring = true ## Turns on the card's ability to look for areas that are monitorable
	card_ui.original_index = card_ui.get_index()
	card_ui.drag_start_position = card_ui.global_position

## Used to handle input while in the clicked state
##
func on_gui_input(event: InputEvent) -> void:
	# When in the clicked state and mouse starts moving it moves to dragging state
	#if event is InputEventMouseMotion:
		#transition_requested.emit(self, CardState.CardState.DRAGGING)
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.CardState.DRAGGING)

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		transition_requested.emit(self, CardState.CardState.BASE)
