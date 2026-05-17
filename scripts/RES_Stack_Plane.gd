extends Control

@onready var back1 = $Back1
@onready var back2 = $Back2
@onready var back3 = $Back3

func _ready():
	GameData.start_planes_changed.connect(_on_start_planes_changed)
	update_stack()

func _on_start_planes_changed(new_count):
	update_stack()

func update_stack():
	var count = GameData.start_planes
	
	back1.visible = count >= 2
	back2.visible = count >= 3
	back3.visible = count >= 4
