class_name EnemyHandler
extends Node2D

@onready var enemy_ui := preload("res://systems/enemy/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func remove_enemies() -> void:
	for child in self.get_children():
		self.remove_child(child) #Maybe don't do it this way.. Updating something you are looping through could be dangerous

func generate_enemy(stats:EnemyStats, anchor: EnemyAnchor) -> void:
	
	#Create Child Enemy
	var new_enemy = enemy_ui.instantiate()
	self.add_child(new_enemy)
	
	#Set its position, scale, and texture
	new_enemy.setup_enemy(stats, anchor)
