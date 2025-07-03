extends StaticBody2D


onready var texture = $AnimatedSprite
# Called when the node enters the scene tree for the first time.
enum TYPE {
	DEF = 0,
	BOUNCE = 1,
	TEMP = 2
}

signal bounce_stepped

export var BRICK_TYPE = TYPE.BOUNCE
#export var DESTROY = false
#export var PLAYER_STEPPED = false
export var EMIT = false

func _process(delta):
	behaviour(delta)


func on_player_stepped() -> Array:
	match BRICK_TYPE:
		TYPE.BOUNCE:
			return [true, 100, -6]
		_:
			return []
	#print("Player stepped on this brick!")
func behaviour(delta):
	#if not PLAYER_STEPPED:
	#	return
	match BRICK_TYPE:
		TYPE.DEF:
			texture.play("idle")
			pass
		TYPE.BOUNCE:
			texture.play("spring_idle")
			pass
		TYPE.TEMP:
			var limit = 10
			var time = 0
			if time >= limit:
				queue_free()
			time += delta
			texture.play("temp")
			pass
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
