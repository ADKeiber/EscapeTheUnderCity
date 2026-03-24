class_name Battle
extends Control

@export var battle_setting: BattleSetting

@onready var battle_landscape: TextureRect = $BattleLandscape
@onready var enemy_handler: EnemyHandler = %EnemyHandler

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Setup scene
	##Background
	battle_landscape.texture = battle_setting.background
	###Enemies
	battle_setting.generate_enemies()
	enemy_handler.remove_enemies()
	for enemy in battle_setting.selected_enemies:
		enemy_handler.generate_enemy(enemy, battle_setting.selected_enemies[enemy])



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
