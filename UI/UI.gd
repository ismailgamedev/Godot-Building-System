extends Control

var bsuh = preload("res://Bush/Bush.tscn")

func _on_Button_pressed():
	var bush_instance = bsuh.instance()
	bush_instance.global_position = get_global_mouse_position()
	get_parent().get_parent().add_child(bush_instance)
