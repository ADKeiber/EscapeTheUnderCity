## Used to dictate valid parameters for setting up an enemy in a scene
class_name EnemyAnchor
extends Resource

@export var simple_name: String
@export var basepoint: Vector2
# indicates how far away a character is (roughly) meant to help dictate size adjustments depending on how far they are
# Note that a character with scale of 1 is considered about 1 meters in front of the player. The player is also about 6 ft tall so scale accordingly
# A character would be slighlty cut off at the bottom if they are 1 meter in front of the player
@export var distance_from_camera: int 
@export var character_scale: float # determines how scaled a character should be... The further away the smaler the scale (could replace distance from camera))
@export var hd_scale: int # determines how scaled the point needs to be... 1 indicates it's in 1080p and doesn't need scaled
