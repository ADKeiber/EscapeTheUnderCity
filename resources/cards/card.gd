## Card Script base class that is extended
## to create specific cards. This class holds
## the basic parts needed to create cards. Used
## as a data container
class_name Card
extends Resource

enum TimeResource {HUMAN, AI}
enum Target {SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE}

@export_group("Card Attributes")
@export var id: String                 ## The ID for the card
@export var target: Target             ## The Target of the card
@export var timeResource: TimeResource ## Which time resource this card consumes
@export var cost: int                ## The time cost of the card in decisecond

@export_group("Card Visuals")
@export var art: Texture                   ## The texture that is viewed on the card
@export_multiline var tooltip_text: String  ## The text that is displayed for the card


## Determines if the target is single target 
##
func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY

## Finds the targets that are avialable based on the card Type
func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets:
		return []
	var tree := targets[0].get_tree()
	match target:
		Target.SELF:
			return tree.get_nodes_in_group("player")
		Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("enemies") 
		_:
			return []

func queue() -> void:
	pass
