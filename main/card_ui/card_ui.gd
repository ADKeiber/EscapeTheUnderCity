## Contains all the code needed for the Card's UI
##
class_name CardUI
extends Control

@export var card: Card: set = _set_card

@onready var panel: Panel = $Panel
@onready var cost: Label = $Cost
@onready var art: TextureRect = $Art
@onready var card_text: RichTextLabel = $CardText

#func _ready() -> void:
	#_set_card(card)

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
