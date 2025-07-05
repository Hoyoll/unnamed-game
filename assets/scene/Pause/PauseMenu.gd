extends Control

var is_paused: bool = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	
func _on_Resume_pressed():
	self.is_paused = false
	
func _on_Restart_pressed():
	get_tree().reload_current_scene()
	
func _on_Quit_pressed():
	get_tree().change_scene("res://assets/scene/MainMenu/MainMenu.tscn")


