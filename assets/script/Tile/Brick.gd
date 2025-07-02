extends StaticBody2D

# Called when the node enters the scene tree for the first time.
enum TYPE {
	DEF = -1,
	BOUNCE = -2,
	TEMP = -3
}
signal bounce_stepped

export var BRICK_TYPE = TYPE.BOUNCE
#export var DESTROY = false
export var PLAYER_STEPPED = false

func _process(_delta):
	behaviour()
			
func behaviour():
	if not PLAYER_STEPPED:
		return
	match BRICK_TYPE:
		TYPE.DEF:
			pass
		TYPE.BOUNCE:
			emit_signal("bounce_stepped")
			print("stepped!")
			pass
		TYPE.TEMP:
			pass
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
