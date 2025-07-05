extends Control

func _on_NewGame_pressed():
	get_tree().change_scene("res://assets/scene/Level/Puzzle_1.tscn")
	

func _on_Quit_pressed():
	get_tree().quit()
