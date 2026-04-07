class_name SingleStat
extends TextureRect

@onready var label: Label = $Label

func update(value: int) -> void:
	#assert(label != null, "SingleStat: Label node not found. Check node path/case.")
	label.text = str(value)
	#label.text = value
