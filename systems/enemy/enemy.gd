class_name Enemy
extends Area2D

var stats: EnemyStats: set = set_enemy_stats
var anchor: EnemyAnchor
@onready var enemy_body: Sprite2D = %EnemyBody
@onready var enemy_hit_box: CollisionShape2D = %EnemyHitBox
@onready var selector_top: Sprite2D = $SelectorTop
@onready var selector_bottom: Sprite2D = $SelectorBottom
@onready var enemy_stats_visuals: EnemyStatsVisuals = $EnemyStatsVisuals

var start_of_turn_stats: EnemyStats

const SELECTOR_SELECTED = preload("res://assets/art/UI/Selector_Selected.png")
const SELECTOR = preload("res://assets/art/UI/Selector.png")

#func _ready() -> void:
	#stats.stats_changed.connect(update_enemy_stats)
	#pass
	
func setup_enemy(new_stats:EnemyStats, new_anchor: EnemyAnchor) -> void:
	stats = new_stats
	anchor = new_anchor
	enemy_body.texture = stats.art
	
	#Setting collision
	var shape = RectangleShape2D.new()
	shape.size = enemy_body.texture.get_size()
	enemy_hit_box.shape = shape
	
	#setting scale and position
	self.scale = Vector2(anchor.character_scale, anchor.character_scale)
	self.position = anchor.basepoint
	
func update_enemy_stats() -> void:
	enemy_stats_visuals.update_stats(stats)

## Sets the stats of an enemy 
##
func set_enemy_stats(value: EnemyStats) -> void:
	stats = value.create_instance()
	start_of_turn_stats = value.create_instance()
	if not stats.stats_changed.is_connected(update_enemy_stats):
		stats.stats_changed.connect(update_enemy_stats)
		stats.stats_changed.connect(update_enemy_stats)
	update_enemy()
	
##  Sets the sprite arrow position, ai, and updates stats
##
func update_enemy() -> void:
	if not stats is Stats:
		return
	if not is_inside_tree():
		await ready
	setup_ai()
	update_enemy_stats()

## Sets up the ai / action picker for an enemy
##
func setup_ai() -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	#selector_bottom.texture = SELECTOR_SELECTED
	#selector_top.texture = SELECTOR_SELECTED
	#selector_top.show();
	#selector_bottom.show();
	enemy_stats_visuals.select()

func _on_area_exited(area: Area2D) -> void:
	#selector_bottom.texture = SELECTOR
	#selector_top.texture = SELECTOR
	#selector_top.hide();
	#selector_bottom.hide();
	enemy_stats_visuals.unselect()
