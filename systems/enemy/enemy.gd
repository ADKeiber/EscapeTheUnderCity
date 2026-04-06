class_name Enemy
extends Area2D

var stats: EnemyStats: set = set_enemy_stats
var anchor: EnemyAnchor
@onready var enemy_body: Sprite2D = %EnemyBody
@onready var enemy_hit_box: CollisionShape2D = %EnemyHitBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
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
	

func set_enemy_stats(new_stats: EnemyStats) -> void:
	stats = new_stats


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
