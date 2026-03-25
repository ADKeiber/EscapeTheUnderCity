extends Node2D

@onready var path_2d: Path2D = $Path2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_cubic_bezier(Vector2(114,1080), Vector2(646,608), Vector2(1268,611), Vector2(1783,1080), 100.0)
	pass # Replace with function body.

func _draw() -> void:
	var points := PackedVector2Array()
	var steps := 100
	for i in range(steps + 1):
		var t:= float(i)/steps
		points.append(_cubic_bezier(Vector2(100,1080), Vector2(646,980), Vector2(1268,980), Vector2(1800,1080), t))
	
	draw_polyline(points, Color.WHITE, 2.0)

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
