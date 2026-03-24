class_name Stats
extends Resource

signal stats_changed

@export var max_health := 10 ## Contains the max health of an entity
@export var art: Texture     ## The art for an entity

var health: int : set = set_health ## The health of the entity
var block : int : set = set_block  ## The block of the entity

## Set's the health of the entity
##
func set_health(value : int) -> void:
	health = clampi(value, 0, max_health)
	stats_changed.emit()

## Sets the block for the entity
##
func set_block(value: int ) -> void:
	block = clampi(value, 0, 999)
	stats_changed.emit()
