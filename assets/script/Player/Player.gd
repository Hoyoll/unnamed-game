extends KinematicBody2D

# Movement variables
var velocity = Vector2()
var speed = 250
var PLAYER_DIR = Direction.LEFT
# Gravity settings
var gravity = 1200  # Pixels per second squared
var jump_force = -400
const JUMP_MOD = 3
enum Player { 
	IDLE = -1, 
	WALKING = -2,
	JUMPING = -3,
	FALLING = -4,
	SMALLJUMP = -5,
}
enum Direction {
	RIGHT = 100,
	LEFT = 101,
}
	
func _physics_process(delta):
	#this is gravity
	velocity.y += gravity * delta
#	velocity.x = 0
	handle_state(handle_io())
	velocity = move_and_slide(velocity, Vector2.UP)

func flip():
	$AnimatedSprite.flip_h = PLAYER_DIR == Direction.LEFT

func handle_io() -> Array:
	var io = []
	var floored = is_on_floor()
	# Ngambil apakah player grounded
	io.append(floored)
	
	# Ngambil apakah button di tekan
	if Input.is_action_pressed("ui_right"):
		PLAYER_DIR = Direction.RIGHT
		io.append(Direction.RIGHT)
	elif Input.is_action_pressed("ui_left"):
		PLAYER_DIR = Direction.LEFT
		io.append(Direction.LEFT)
	else: 
		io.append(Player.IDLE)
		
	# Ngambil apakah button lompat di tekan
	if Input.is_action_just_pressed("ui_up"):
		io.append(Player.JUMPING)
	elif Input.is_action_just_released("ui_up"):
		io.append(Player.SMALLJUMP)
	flip()
	return io

func handle_state(data: Array):
	match data:
		[_, Direction.RIGHT]:
			$AnimatedSprite.play("walk")
			velocity.x = speed
		[_, Direction.LEFT]:
			$AnimatedSprite.play("walk")
			velocity.x = -speed
		[true, Player.IDLE]:
			$AnimatedSprite.play("idle")
			velocity.x = 0
		[true, _, Player.JUMPING]:
			velocity.y = jump_force
		[true, _, Player.SMALLJUMP]:
			velocity.y = jump_force / JUMP_MOD
		_:
			$AnimatedSprite.play("idle")			
			velocity.x = 0  # default fallback
