extends Node2D

var builded = false
var col_detector : bool

func _ready():
	set_process_input(true)
	
func _physics_process(delta):
	if builded == false:
		position = position.snapped(Vector2(32,32))
		position = get_global_mouse_position()
		$StaticBody2D/Bush.self_modulate.a8 = 100
		$StaticBody2D/CollisionShape2D.disabled = true
		
func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and builded == false and col_detector == false:
		position = get_global_mouse_position()
		$StaticBody2D/Bush.self_modulate.a8 = 255
		$StaticBody2D/CollisionShape2D.disabled = false
		builded = true

func _on_CollisionDetector_area_entered(area):
	if builded == false:
		col_detector = true
		$ColorRect.visible = true

func _on_CollisionDetector_area_exited(area):
	if builded == false:
		col_detector = false
		$StaticBody2D/Bush.self_modulate.darkened(255)
		$ColorRect.visible = false
