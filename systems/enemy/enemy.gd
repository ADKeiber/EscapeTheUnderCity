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
	#Get global postion of the character... move stats by the offset.... Multiply the move by the scale since its original is 1x1
	#var x_offset = stats.top_head_location_offset.x 
	#var y_offset = stats.top_head_location_offset.y
	#enemy_stats_visuals.global_position = Vector2(self.global_position.x + x_offset, self.global_position.y - (y_offset * self.scale.y))
	
	#enemy_stats_visuals.position =  enemy_body.position + (stats.head_offset_from_center - Vector2((enemy_stats_visuals.size.x/2) * self.scale.x,(enemy_stats_visuals.size.y/2) * self.scale.y * -1))
	
	
	
	#var enemy_stats_visuls_x = enemy_body.position.x
	#var enemy_stats_visuls_y = enemy_body.position.y + stats.head_offset_from_center.y - enemy_stats_visuals.size.y/2
	#enemy_stats_visuals.position = Vector2(enemy_stats_visuls_x, enemy_stats_visuls_y)
	#print(enemy_stats_visuals.size.x)
	#print((enemy_stats_visuals.size.x/2) * self.scale.x)
	#print(self.scale.x)
	
	
	
	
	#enemy_stats_visuals.position = top_head_marker.position - Vector2(enemy_stats_visuals.size.x/2.0, enemy_stats_visuals.size.y/2.0)

func update_enemy_stats() -> void:
	#enemy_stats_visuals.update_stats(stats)
	pass

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
