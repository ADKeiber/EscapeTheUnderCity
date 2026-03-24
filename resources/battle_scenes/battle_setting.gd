# Resource Class used to determine battle locations, enemies, and other important information
class_name BattleSetting
extends Resource

@export var valid_enemies: Array[EnemyStats] # Enemies that are valid at a specific location
@export var background: Texture #Background image of a battle location
@export var enemy_anchors: Array[EnemyAnchor] # Dictates valid parameters for enemies to be
@export var num_enemies: int # The amount of enemies to select
var selected_enemies: Dictionary[EnemyStats,EnemyAnchor] # Enemies determined for a particular instance and their anchor location
#TODO Determine render layer - Enemies closer should render on top of those further...
func generate_enemies() -> void:
	# Select Enemy
	for n in num_enemies:
		var enemy_index = randi_range(0,valid_enemies.size()-1) # gets random int to be used to index enemies
		var enemy_anchor_index = randi_range(0,enemy_anchors.size()-1)
		selected_enemies[valid_enemies[enemy_index]] = enemy_anchors[enemy_anchor_index]
