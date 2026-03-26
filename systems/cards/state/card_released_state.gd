## Card State used after a card was in a dragging state and was released
##
class_name CardReleasedState
extends CardState

var played: bool

## Activates when entering the released state
##
func enter() -> void:
	played = false
	# Only goes here if there is a valid target
	if not card_ui.targets.is_empty():
		Events.tooltip_hide_requested.emit()
		played = true
		card_ui.play_to_queue()

## Activates when there is an input when in the released state
##
func on_input(_event: InputEvent) -> void:
	if played:
		return
	
	transition_requested.emit(self, CardState.State.BASE)
