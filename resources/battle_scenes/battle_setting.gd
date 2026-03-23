# Resource Class used to determine battle locations, enemies, and other important information
class_name BattleSetting
extends Resource

@export var valid_enemies: Array[Enemy] # Enemies that are valid at a specific location
@export var background: Texture #Background image of a battle location
@export var enemy_anchors: Array[Vector2] # X,Y cordinates where the center base of an enemy can be positioned.. These anchor or in order to which they should be filled
@export var num_enemies: int # The amount of enemies to select
var selected_enemies: Dictionary[Enemy,Vector2] # Enemies determined for a particular instance and their anchor location

func generate_enemies() -> void:
	# Select Enemy
	for n in num_enemies:
		var enemy_index = randi_range(0,valid_enemies.size()-1) # gets random int to be used to index enemies
		selected_enemies[valid_enemies[enemy_index]] = enemy_anchors[n]
