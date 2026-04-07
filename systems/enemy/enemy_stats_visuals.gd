class_name EnemyStatsVisuals
extends Control

@onready var block: SingleStat = $HBoxContainer/Block
@onready var health: SingleStat = $HBoxContainer/Health
@onready var bracket_up: TextureRect = $HBoxContainer/BracketUp
@onready var bracket_low: TextureRect = $HBoxContainer/BracketLow

const SELECTOR_SELECTED = preload("res://assets/art/UI/Selector_Selected.png")
const SELECTOR = preload("res://assets/art/UI/Selector.png")

func update_stats(stats: Stats) -> void:
	health.update(stats.health)
	if stats.block == 0:
		block.hide()
	else:
		block.update(stats.block)

func select() -> void:
	bracket_up.texture = SELECTOR_SELECTED
	bracket_low.texture = SELECTOR_SELECTED

func unselect() -> void:
	bracket_up.texture = SELECTOR
	bracket_low.texture = SELECTOR
