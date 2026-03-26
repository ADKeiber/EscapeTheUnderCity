## Base class for all Card States
##
class_name CardState
extends Node

enum State {BASE, CLICKED, DRAGGING, AIMING, RELEASED} # All the different states a card can be in

signal transition_requested(from: CardState, to: State) 

@export var state: State

#var card_ui: CardUI

## Uninplemented enter function for card state
##
func enter() -> void:
	pass

## Uninplemented exit function for card state
##
func exit() -> void:
	pass

## Uninplemented input function for card state
##
func on_input(_event: InputEvent) -> void:
	pass

## Uninplemented on gui input function for card state
##
func on_gui_input(_event: InputEvent) -> void:
	pass

## Uninplemented on mouse enter function for card state
##
func on_mouse_entered() -> void:
	pass

## Uninplemented on mouse exited function for card state
##
func on_mouse_exited() -> void:
	pass
