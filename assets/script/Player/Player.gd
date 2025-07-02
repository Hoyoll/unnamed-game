extends KinematicBody2D

onready var player_sprite = $AnimatedSprite
onready var wrench_sprite = $Wrench/AnimatedSprite
# Movement variables
var brick = preload("res://assets/scene/Brick/Brick.tscn")
var velocity = Vector2()
var speed = 250
var PLAYER_DIR = Direction.LEFT
# Gravity settings
var gravity = 1200  # Pixels per second squared
var jump_force = -80
const JUMP_MOD = 3
var JUMP_BUFF := 3.0
enum Player { 
	IDLE = -1, 
	WALKING = -2,
	BUFFERING = -3,
	FALLING = -4,
	JUMPING = -5,
}
enum Direction {
	RIGHT = 100,
	LEFT = 101,
}

func _ready():
	var brscn = brick.instance()
	brscn.connect("bounce_stepped", self, "jump")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func jump():
	velocity.y = jump_force * 3
	print("here!")
	
func _physics_process(delta):
	#this is gravity
	velocity.y += gravity * delta
#	velocity.x = 0
	#if mouse_pos.y > global_position.y: #or mouse_pos.x < global_position.x:
	#	wrench_sprite.flip_v = true
	#else:
		#wrench_sprite.flip_v = false
	handle_state(handle_io())
	velocity = move_and_slide(velocity, Vector2.UP)

func flip():
	player_sprite.flip_h = PLAYER_DIR == Direction.LEFT
	wrench_sprite.flip_v = PLAYER_DIR == Direction.RIGHT
	

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
#	if Input.is_action_pressed("ui_up"):
#		io.append(Player.BUFFERING)
	if Input.is_action_just_pressed("ui_up"):
		io.append(Player.JUMPING)
	flip()
	return io

func handle_state(data: Array):
	match data:
		[true, Direction.RIGHT]:
			$AnimatedSprite.play("walk")
			velocity.x = speed
		[true, Direction.LEFT]:
			$AnimatedSprite.play("walk")
			velocity.x = -speed
		
		[false, Direction.RIGHT]:
			#$AnimatedSprite.play("walk")
			velocity.x = speed
		[false, Direction.LEFT]:
			#$AnimatedSprite.play("walk")
			velocity.x = -speed
		[true, Player.IDLE]:
			$AnimatedSprite.play("idle")
			velocity.x = 0
		[true, _, Player.BUFFERING]:
			if JUMP_BUFF < 5.0:
				JUMP_BUFF += 0.5
			#velocity.y = jump_force
		[true, _, Player.JUMPING]:
			velocity.y = jump_force * JUMP_BUFF
#			JUMP_BUFF = 0.0
		_:
			$AnimatedSprite.play("idle")			
			velocity.x = 0  # default fallback
