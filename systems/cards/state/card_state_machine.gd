## Contains the logic for updating card state
##
class_name CardStateMachine
extends Node

@export var initial_state: CardState

var current_state: CardState ## Carries the current state of a card
var states := {}

## Creates the Card State machine that allows for a card to interact with the machine
##
func init(card: CardUI) -> void:
	#setting hover states:
	for child in get_children():
		if child is CardState:
			states[child.card_state] = child
			# Connects the transition requested method to child nodes that are CardStates
			child.transition_requested.connect(_on_transition_requested) 
			child.card_ui = card
	if initial_state != null:
		initial_state.enter()
		current_state = initial_state


## Handles the input event for the current state
##
func _input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)

## Handles the gui input event for the current state
##
func on_gui_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)

## Handles mouse entered event for the current state
##
func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()

## Handles mouse exited event for the current state
##
func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()

## Handles the transition between the current state and the next state
##
func _on_transition_requested(from: CardState, to: CardState.CardState) -> void:
	if from != current_state:
		return
	
	var new_state: CardState = states[to]
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
