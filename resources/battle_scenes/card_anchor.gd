#Class dictates where a card should be
# EX: If a player can have 3 human cards and 5 AI cards there should be 8 total anchors on the screen
# After a card is played that anchor will need to "spawn" (draw) a new card
# These anchors should be plotted along a curve
class_name CardAnchor
extends Resource

@export var card: Card
@export var position: Vector2
@export var resource_type: Card.TimeResource
@export var resource_index: int
