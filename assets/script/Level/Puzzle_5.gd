extends Node2D



func _ready():
	$DoorPositive.connect("body_entered", self, "_change_level")
	pass # Replace with function body.

func _change_level(body):
	if body.name == "Player":
		get_tree().change_scene("res://assets/scene/MainMenu/Ending.tscn")
		#print("Finished!")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
