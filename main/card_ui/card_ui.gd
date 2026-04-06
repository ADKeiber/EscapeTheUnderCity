## Contains all the code needed for the Card's UI
##
class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI)

const BASE_STYLEBOX = preload("res://resources/styles/cards/card_base_stylebox.tres")
const DRAGGING_STYLEBOX = preload("res://resources/styles/cards/card_dragging_stylebox.tres")
const HOVER_STYLE_BOX = preload("res://resources/styles/cards/card_hover_style_box.tres")

@export var card: Card: set = _set_card

@onready var panel: Panel = $Panel
@onready var cost: Label = $Cost
@onready var art: TextureRect = $Art
@onready var card_text: RichTextLabel = $CardText
@onready var drop_point_detector = $DropPointDetector
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets: Array[Node] = []

var anchor : CardAnchor = CardAnchor.new()
var tween: Tween
var playable = true
var disabled = false
var original_index: int
var drag_start_position: Vector2

func _ready() -> void:
	Signals.card_drag_started.connect(_on_card_drag_or_aiming_started)
	Signals.card_drag_ended.connect(_on_card_drag_or_aim_ended)
	Signals.card_aim_started.connect(_on_card_drag_or_aiming_started) 
	Signals.card_aim_ended.connect(_on_card_drag_or_aim_ended)
	card_state_machine.init(self)

	
## Sets the cad's value, cost, texture and icon
##
func _set_card(value: Card) -> void:
	if not is_node_ready():
		await ready
	card = value
	cost.text = str(card.cost)
	art.texture = card.art
	card_text.text = card.tooltip_text
	#match card.timeResource:
		#Card.TimeResource.HUMAN:
			#text_color = Color(0.294,0.412,0.184,1.0)
		#Card.TimeResource.AI: 
			#text_color = Color(0.388,0.608,1,1.0)
	#cost.add_theme_color_override("font_color", text_color)


func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

## Handles the mouse entered event for this card
##
func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

## Handles the mouse exited event for this card
##
func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()

## Handles the targets when an area is detected by add it
##
func _on_drop_point_detector_area_entered(area) -> void:
	if not targets.has(area):
		targets.append(area)

## Handles the targets when an area is detected by removing it
##
func _on_drop_point_detector_area_exited(area):
	#pass
	targets.erase(area)

## Card Event methods
## Disables other cards that aren't this card
##
func _on_card_drag_or_aiming_started(used_card: CardUI) -> void:
	if used_card == self:
		return
	disabled = true

## Enables card when card drag or aim ended
##
func _on_card_drag_or_aim_ended(_card: CardUI) -> void:
		disabled = false
		self.playable = State.player_stats.can_play_card(card)

## Animates movement of a card using tween
##
func animate_to_position(new_position: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)
