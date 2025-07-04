extends Area2D


# Declare member variables here. Examples:

func _ready():
	connect("body_entered", self, "_on_body_entered")
#	pass # Replace with function body.
	

func _on_body_entered(body):
	if body.name == "Player":
		var parent = get_parent()
		match parent.BRICK_TYPE:
				1:
					parent.emit_signal("bounce_stepped")
					#print("body stepped")
#				emit_signal("bounce_stepped")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
