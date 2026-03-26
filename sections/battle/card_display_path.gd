class_name CardDisplayPath
extends Node2D

@onready var path_2d: Path2D = $Path2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_cubic_bezier(Vector2(114,1080), Vector2(646,608), Vector2(1268,611), Vector2(1783,1080), 100.0)
	pass # Replace with function body.

func _draw() -> void:
	var points := PackedVector2Array()
	var steps :=  172 #TODO update to be resolution based.. currently its a point every 10 pixles (kind of)
	for i in range(steps + 1):
		var t:= float(i)/steps
		points.append(_cubic_bezier(Vector2(000,1000), Vector2(646,900), Vector2(1268,900), Vector2(1920,1000), t))
	
	draw_polyline(points, Color.WHITE, 2.0)
	var anchor_count: int  = 0
	# Calculate Card Anchor points (where to place the cards)
	var points_between_card: int = 20 # Effectively this number x 10 = px between card midpoints
	var anchors: Array[CardAnchor]
	#Calculate human hand first
	var left_middle: int = steps/4
	var human_card_amount: int = State.player_stats.human_hand_max
	if human_card_amount % 2 != 0: # its odd
		var card_anchor: CardAnchor = CardAnchor.new() # center card
		card_anchor.position = points.get(left_middle)
		card_anchor.resource_type = Card.TimeResource.HUMAN
		anchors.append(card_anchor)
		anchor_count += 1
		for i in range((human_card_amount - 1) /2): # finds half the points (after removing 1(the middle))
			var card_anchor1: CardAnchor = CardAnchor.new() # right
			card_anchor1.position = points.get(left_middle + (points_between_card * (i + 1)))
			card_anchor1.resource_type = Card.TimeResource.HUMAN
			anchors.append(card_anchor1)
			anchor_count += 1
			var card_anchor2: CardAnchor = CardAnchor.new() # left
			card_anchor2.position = points.get(left_middle - (points_between_card * (i + 1)))
			card_anchor2.resource_type = Card.TimeResource.HUMAN
			anchors.append(card_anchor2)
			anchor_count += 1
	else: # its an even amount of cards
		var cl_card_anchor: CardAnchor = CardAnchor.new() # center_left card
		cl_card_anchor.position = points.get(left_middle - (points_between_card/2))
		cl_card_anchor.resource_type = Card.TimeResource.HUMAN
		anchors.append(cl_card_anchor)
		anchor_count += 1
		var cr_card_anchor: CardAnchor = CardAnchor.new() # center_left card
		cr_card_anchor.position = points.get(left_middle + (points_between_card/2))
		cr_card_anchor.resource_type = Card.TimeResource.HUMAN
		anchors.append(cr_card_anchor)
		anchor_count += 1
		for i in range((human_card_amount - 2) /2): # finds half the points (after removing 2(the 2 middle))
			var card_anchor1: CardAnchor = CardAnchor.new() # right
			var index = left_middle + (points_between_card/2) + (points_between_card * (i + 1))
			card_anchor1.position = points.get(left_middle + (points_between_card/2) + (points_between_card * (i + 1)))
			card_anchor1.resource_type = Card.TimeResource.HUMAN
			anchors.append(card_anchor1)
			anchor_count += 1
			var card_anchor2: CardAnchor = CardAnchor.new() # left
			card_anchor2.position = points.get(left_middle - (points_between_card/2) - (points_between_card * (i + 1)))
			card_anchor2.resource_type = Card.TimeResource.HUMAN
			anchors.append(card_anchor2)
			anchor_count += 1
	#
	#State.player_stats.card_anchors.append_array(anchors)
	# FIND CARD ANCHORS FOR AI CARDS
	var right_middle: int = steps * .75
	
	var ai_card_amount: int = State.player_stats.ai_hand_max
	
	if ai_card_amount % 2 != 0: # its odd
		var card_anchor: CardAnchor = CardAnchor.new() # center card
		card_anchor.position = points.get(right_middle)
		card_anchor.resource_type = Card.TimeResource.AI
		anchors.append(card_anchor)
		anchor_count += 1
		for i in range((ai_card_amount - 1) /2): # finds half the points (after removing 1(the middle))
			var card_anchor1: CardAnchor = CardAnchor.new() # right
			card_anchor1.position = points.get(right_middle + (points_between_card * (i + 1)))
			card_anchor1.resource_type = Card.TimeResource.AI
			anchors.append(card_anchor1)
			var card_anchor2: CardAnchor = CardAnchor.new() # left
			card_anchor2.position = points.get(right_middle - (points_between_card * (i + 1)))
			card_anchor2.resource_type = Card.TimeResource.AI
			anchors.append(card_anchor2)
			anchor_count += 1
	else: # its an even amount of cards
		var cl_card_anchor: CardAnchor = CardAnchor.new() # center_left card
		cl_card_anchor.position = points.get(right_middle - (points_between_card/2))
		cl_card_anchor.resource_type = Card.TimeResource.AI
		anchors.append(cl_card_anchor)
		anchor_count += 1
		var cr_card_anchor: CardAnchor = CardAnchor.new() # center_left card
		cr_card_anchor.position = points.get(right_middle + (points_between_card/2))
		cr_card_anchor.resource_type = Card.TimeResource.AI
		anchors.append(cr_card_anchor)
		anchor_count += 1
		for i in range((ai_card_amount - 2) /2): # finds half the points (after removing 2(the 2 middle))
			var card_anchor1: CardAnchor = CardAnchor.new() # right
			card_anchor1.position = points.get(right_middle + (points_between_card/2) + (points_between_card * (i + 1)))
			card_anchor1.resource_type = Card.TimeResource.AI
			anchors.append(card_anchor1)
			anchor_count += 1
			var card_anchor2: CardAnchor = CardAnchor.new() # left
			card_anchor2.position = points.get(right_middle - (points_between_card/2) - (points_between_card * (i + 1)))
			card_anchor2.resource_type = Card.TimeResource.AI
			anchors.append(card_anchor2)
			anchor_count += 1
	State.player_stats.card_anchors.append_array(anchors)
	
	#TEMP
	var dot_radius = 10.0                # Size of the dot
	var dot_color = Color.RED           # Color of the dot

	for anchor in State.player_stats.card_anchors:
		draw_circle(anchor.position, dot_radius, dot_color)
	print("ANCHORS AWAY!")

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r

func _cubic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var q2 = p2.lerp(p3, t)
	var r0 = q0.lerp(q1, t)
	var r1 = q1.lerp(q2, t)
	var s = r0.lerp(r1, t)
	return s

func create_anchors_for_tr_type(resource: Card.TimeResource) -> Array[CardAnchor]:
	#var middle = 
	var anchors: Array[CardAnchor]
	
	return anchors
