extends StaticBody2D


onready var texture = $AnimatedSprite
enum TYPE {
	DEF = 0,
	BOUNCE = 1,
	TEMP = 2
}

export var BRICK_TYPE = TYPE.BOUNCE

func _process(delta):
	behaviour(delta)

func on_player_stepped() -> Array:
	match BRICK_TYPE:
		TYPE.BOUNCE:
			return [true, 100, -6]
		_:
			return []
func behaviour(_delta):
	match BRICK_TYPE:
		TYPE.DEF:
			texture.play("idle")
			pass
		TYPE.BOUNCE:
			texture.play("spring_idle")
			pass
		TYPE.TEMP:
			texture.play("temp")
			pass
