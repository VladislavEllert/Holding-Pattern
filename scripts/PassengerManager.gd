extends Node

var passengers: Array = []
var new_passenger_scale: float = 1.0


func spawn_passenger(my_shape):
	var current_shapes = []

	var existing_airport_types = []
	for airport in get_tree().get_nodes_in_group("airports"):
		if not existing_airport_types.has(airport.my_shape):
			existing_airport_types.append(airport.my_shape)
	
	for shape in GameData.ShapeType.values():
		if shape != my_shape and existing_airport_types.has(shape):
			current_shapes.append(shape)
	
	if current_shapes.is_empty():
		return

	SoundManager.play("spawn_passengers")
	var passenger_shape = current_shapes.pick_random()
	passengers.append(passenger_shape)
	
	new_passenger_scale = 0.0
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_method(_animation_spawn_pass_, 0.0, 1.0, 0.3)

func _animation_spawn_pass_(value: float):
	new_passenger_scale = value


func draw_passengers(drawer: Node2D):
	var start_pos = Vector2(22, -8)
	var spacing = 15
	var max_in_row = 5
	var passenger_color = Color(0.173, 0.157, 0.173, 1.0)
	var p_size = 7
	if drawer.is_big:
		max_in_row += 1
		for i in range(passengers.size()):
			var shape = passengers[i]
			@warning_ignore("integer_division")
			var row = int(i / max_in_row)
			var col = i % max_in_row
			var pos
			var revers_col
			
			var current_scale = 1.0
			if i == passengers.size() - 1:
				current_scale = new_passenger_scale
			
			if i == drawer.max_passengers - 5:
				start_pos = Vector2(32, -6)
				pos = start_pos + Vector2(col * spacing, row * spacing)
				passenger_color.a = 0.86
			
			elif i > drawer.max_passengers - 5:
				start_pos = Vector2(15, -11)
				revers_col = (max_in_row - 1) - col
				pos = start_pos + Vector2(revers_col * spacing, row * spacing)
				passenger_color.a = 0.73
			
			else:
				start_pos = Vector2(30, -13)
				pos = start_pos + Vector2(col * spacing, row * spacing)
			
			if i > drawer.max_passengers + 1:
				break
			
			match shape:
				GameData.ShapeType.CIRCLE:
					drawer.draw_circle(pos, p_size * current_scale, passenger_color)
					
				GameData.ShapeType.SQUARE:
					var s = p_size * current_scale
					var rect = Rect2(pos - Vector2(s, s), Vector2(s * 2, s * 2))
					drawer.draw_rect(rect, passenger_color, true)
					
				GameData.ShapeType.TRIANGLE:
					var size = p_size * current_scale * 2.2
					var h = size * sqrt(3) / 2
					var points = PackedVector2Array([
						pos + Vector2(0, -h/2),
						pos + Vector2(size/2, h/2),
						pos + Vector2(-size/2, h/2)
					])
					drawer.draw_colored_polygon(points, passenger_color)
					
				GameData.ShapeType.PENTAGON:
					var size = p_size * 1.0 * 1.2
					var points = PackedVector2Array()
					for c in range(5):
						var angle = deg_to_rad(c * 72 - 90)
						points.append(pos + Vector2(cos(angle), sin(angle)) * size)
					drawer.draw_colored_polygon(points, passenger_color)
					
				GameData.ShapeType.GEM:
					var sw = p_size * 0.8 * 1.0 # Ширина
					var sh = p_size * 0.7 * 1.5 # Высота
					var points = PackedVector2Array([
						pos + Vector2(0, -sh), # Верх
						pos + Vector2(sw, 0),  # Право
						pos + Vector2(0, sh),  # Низ
						pos + Vector2(-sw, 0)  # Лево
					])
					drawer.draw_colored_polygon(points, passenger_color)
					
				GameData.ShapeType.PLUS:
					var s = p_size * 0.5 * 1.9
					var t = s * 0.3 # Толщина перекладин
					var points = PackedVector2Array([
						pos + Vector2(-t, -s), pos + Vector2(t, -s), pos + Vector2(t, -t),   # Верх
						pos + Vector2(s, -t),  pos + Vector2(s, t),  pos + Vector2(t, t),    # Право
						pos + Vector2(t, s),   pos + Vector2(-t, s), pos + Vector2(-t, t),   # Низ
						pos + Vector2(-s, t),  pos + Vector2(-s, -t), pos + Vector2(-t, -t)  # Лево
					])
					drawer.draw_colored_polygon(points, passenger_color)

	else:
		for i in range(passengers.size()):
			var shape = passengers[i]
			@warning_ignore("integer_division")
			var row = int(i / max_in_row)
			var col = i % max_in_row
			var pos
			var revers_col
			
			var current_scale = 1.0
			if i == passengers.size() - 1:
				current_scale = new_passenger_scale
			
			if i == drawer.max_passengers - 2:
				start_pos = Vector2(32, -6)
				pos = start_pos + Vector2(col * spacing, row * spacing)
				passenger_color.a = 0.86
			
			elif i > drawer.max_passengers - 2:
				start_pos = Vector2(15, -11)
				revers_col = (max_in_row - 1) - col
				pos = start_pos + Vector2(revers_col * spacing, row * spacing)
				passenger_color.a = 0.73
			
			else:
				start_pos = Vector2(30, -13)
				pos = start_pos + Vector2(col * spacing, row * spacing)
			
			if i > drawer.max_passengers + 1:
				break
			
			match shape:
				GameData.ShapeType.CIRCLE:
					drawer.draw_circle(pos, p_size * current_scale, passenger_color)
					
				GameData.ShapeType.SQUARE:
					var s = p_size * current_scale
					var rect = Rect2(pos - Vector2(s, s), Vector2(s * 2, s * 2))
					drawer.draw_rect(rect, passenger_color, true)
					
				GameData.ShapeType.TRIANGLE:
					var size = p_size * current_scale * 2.2
					var h = size * sqrt(3) / 2
					var points = PackedVector2Array([
						pos + Vector2(0, -h/2),
						pos + Vector2(size/2, h/2),
						pos + Vector2(-size/2, h/2)
					])
					drawer.draw_colored_polygon(points, passenger_color)
					
				GameData.ShapeType.PENTAGON:
					var size = p_size * current_scale * 1.2
					var points = PackedVector2Array()
					for c in range(5):
						var angle = deg_to_rad(c * 72 - 90)
						points.append(pos + Vector2(cos(angle), sin(angle)) * size)
					drawer.draw_colored_polygon(points, passenger_color)
					
				GameData.ShapeType.GEM:
					var sw = p_size * current_scale * 1.1
					var sh = p_size * current_scale * 1.5
					var points = PackedVector2Array([
						pos + Vector2(0, -sh),
						pos + Vector2(sw, 0),
						pos + Vector2(0, sh),
						pos + Vector2(-sw, 0)
					])
					drawer.draw_colored_polygon(points, passenger_color)
					
				GameData.ShapeType.PLUS:
					var s = p_size * current_scale * 0.8
					var t = s * 0.4
					var points = PackedVector2Array([
						pos + Vector2(-t, -s), pos + Vector2(t, -s), pos + Vector2(t, -t),
						pos + Vector2(s, -t),  pos + Vector2(s, t),  pos + Vector2(t, t),
						pos + Vector2(t, s),   pos + Vector2(-t, s), pos + Vector2(-t, t),
						pos + Vector2(-s, t),  pos + Vector2(-s, -t), pos + Vector2(-t, -t)
					])
					drawer.draw_colored_polygon(points, passenger_color)
				
				
