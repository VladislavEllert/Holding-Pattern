extends Node2D

func _draw():
	var radius = 15.0
	var line_width = 3.5
	var color_bg = Color.DARK_GRAY
	var color_icon = Color(0.918, 0.0, 0.0, 0.514)
 
	draw_circle(Vector2.ZERO, radius, color_bg)
 
	draw_arc(Vector2.ZERO, radius - 4, 0, TAU, 32, color_icon, line_width, true)
 
	var angle = deg_to_rad(45)
	var offset = Vector2(cos(angle), sin(angle)) * (radius - 4)
	draw_line(-offset, offset, color_icon, line_width, true)

func _process(_delta):
	queue_redraw()
