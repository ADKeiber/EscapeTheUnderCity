class_name Stats
extends Resource

signal stats_changed
@export var max_health := 10 ## Contains the max health of an entity

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

## Deals damage to the entity
##
func take_damage(damage: int) -> void:
	if damage <= 0:
		return
	var initial_damage = damage
	damage = clampi(damage - block, 0, damage)
	self.block = clampi(block - initial_damage, 0, block)
	self.health -= damage
	stats_changed.emit()

## Heals the entity
##
func heal(amount: int) -> void:
	if self.health + amount > self.max_health:
		self.health = max_health
	else:
		self.health += amount
	stats_changed.emit()

## Creates and instance of the entity
##
func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	return instance
