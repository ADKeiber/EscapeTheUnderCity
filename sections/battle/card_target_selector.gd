## Card target selector that creates a line and allows for a card to 
## select a specific target
##
class_name CardTargetSelector
extends Control

const ARC_POINTS := 10 

@onready var area_2d: Area2D = $Area2D               # The area2D of the target
@onready var card_arc: Line2D = $CanvasLayer/CardArc # The Arc of the selector

var current_card: CardUI                             # The current card that is targeting
var targeting := false                               # if the card is targeting

## on creation hooks up the methods for aiming started and aiming ended 
##
func _ready() -> void:
	Signals.card_aim_started.connect(_on_card_aim_started)
	Signals.card_aim_ended.connect(_on_card_aim_ended)
	z_as_relative = false
	z_index = 1000
	card_arc.z_as_relative = false
	card_arc.z_index = 1000
## Moves that arc and creates the arc points
##
func _process(_delta: float) -> void:
	if not targeting: ## this is updated when the _on_card_aim_started is activated
		return
	
	area_2d.position = get_local_mouse_position() # Movement of the card
	card_arc.points = _get_points()               # creates the points for the arc

## Creates the points for the aiming arc
##
func _get_points() -> Array:
	var points := []
	var start := current_card.global_position
	start.x += current_card.size.x/2
	var target := get_local_mouse_position()
	var distance := target - start
	
	for i in range(ARC_POINTS):
		var t := (1.0 / ARC_POINTS) * i
		var x := start.x + (distance.x / ARC_POINTS) * i
		var y := start.y + ease_out_cubic(t) * distance.y
		points.append(Vector2(x,y))
	
	points.append(target)
	return points

## Used to make the arc smoother
func ease_out_cubic(number: float) -> float:
	return 1.0 - pow(1.0 - number, 3.0)

## Starts the aiming process for a card
##
func _on_card_aim_started(card: CardUI) -> void:
	if not card.card.is_single_targeted():
		return
	targeting = true
	area_2d.monitorable = true   # Others monitoring can detect this
	area_2d.monitoring = true    # Can detect others that are monitorable
	current_card = card

## Ends the aiming process for a card
##
func _on_card_aim_ended(_card: CardUI) -> void:
	targeting = false
	card_arc.clear_points()
	area_2d.position = Vector2.ZERO
	area_2d.monitorable = false        ## Can't be seen
	area_2d.monitoring = false         ## Can't see others
	current_card = null

## Adds an area (enemy) to current selected card target
##
func _on_area_2d_area_entered(area: Area2D) -> void:
	if not current_card or not targeting:
		return
	
	if not current_card.targets.has(area):
		current_card.targets.append(area)

## Removes a current_card's target (enemy)
##
func _on_area_2d_area_exited(area: Area2D) -> void:
	if not current_card or not targeting:
		return
	
	current_card.targets.erase(area)
