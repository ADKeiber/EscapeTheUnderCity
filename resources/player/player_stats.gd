class_name PlayerStats
extends Stats

@export var human_starting_deck: CardPile ## The character's starting deck
@export var ai_starting_deck: CardPile ## The character's starting deck
@export var ai_hand_max: int
@export var ai_queue_max: int
@export var human_hand_max: int
@export var human_queue_max: int

var human_queue_time: int : set = set_human_queue_time ## current queue time of human resource
var ai_queue_time: int : set = set_ai_queue_time       ## current queue time of ai resource

var human_deck: CardPile                           ## Entire human deck of a character
var human_discard: CardPile                           ## The pile of discarded cards for the character 
var human_draw_pile: CardPile

var ai_deck: CardPile                              ## Entire ai deck of a character
var ai_discard: CardPile   
var ai_draw_pile: CardPile                          ## The pile of drawable cards for the character


##  Sets the time queued for a character
##
func set_human_queue_time(value: int) -> void:
	human_queue_time = value
	stats_changed.emit()

##  Sets the time queued for a character
##
func set_ai_queue_time(value: int) -> void:
	ai_queue_time = value
	stats_changed.emit()

func create_instance() -> Resource:
	var instance: PlayerStats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	instance.human_deck = instance.human_starting_deck.duplicate()
	instance.ai_deck = instance.ai_starting_deck.duplicate()
	instance.ai_draw_pile = CardPile.new()
	instance.human_draw_pile = CardPile.new()
	instance.ai_discard = CardPile.new()
	instance.human_discard = CardPile.new()
	return instance
