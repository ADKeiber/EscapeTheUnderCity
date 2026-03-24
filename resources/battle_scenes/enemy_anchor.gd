## Used to dictate valid parameters for setting up an enemy in a scene
class_name EnemyAnchor
extends Resource

@export var basepoint: Vector2
# indicates how far away a character is (roughly) meant to help dictate size adjustments depending on how far they are
# Note that a character with scale of 1 is considered about 2 meters in front of the player
@export var distance_from_camera: int 
@export var min_height: int
@export var max_height: int
@export var min_width: int
@export var max_width: int
