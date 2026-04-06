## Card State used after a card was in a dragging state and was released
##
class_name CardReleasedState
extends CardState

var played: bool

## Activates when entering the released state
##
func enter() -> void:
	played = false
	#await get_tree().physics_frame
	#card_ui.targets = get_current_targets()
	var has_valid_target = card_ui.card.contains_valid_target(card_ui.targets)
	# Only goes here if there is a valid target
	if has_valid_target:
		#Events.tooltip_hide_requested.emit()
		played = true
		card_ui.disabled = true
		card_ui.playable = false
		card_ui.queue_free() #TODO emit card played
	else:
		#card_ui.position = card_ui.anchor.position
		card_ui.animate_to_position(card_ui.anchor.position, 0.4)
		#card_ui.play_to_queue()

## Activates when there is an input when in the released state
##
func on_gui_input(_event: InputEvent) -> void:
	if played:
		return
	transition_requested.emit(self, CardState.CardState.BASE)

func get_current_targets() -> Array[Node]:
	var targets: Array[Node] = []
	for area in card_ui.drop_point_detector.get_overlapping_areas():
		print("Detected: ", area.name)
		if area.is_in_group("drop_area"):
			targets.append(area)
	
	return targets
