class_name SignalBus
extends Node

#Completion Signals - Used to signal a piece of data is ready... Helps prevent = NIL errors
signal card_anchors_ready()

#Card-related events
signal card_drag_started(card_ui: CardUI)
signal card_drag_ended(card_ui: CardUI)
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
signal card_played(card: Card)
signal card_tooltip_requested(card: Card)
signal tooltip_hide_requested
