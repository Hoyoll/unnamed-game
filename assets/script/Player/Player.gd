extends KinematicBody2D

onready var player_sprite = $AnimatedSprite
onready var wrench_sprite = $Wrench/AnimatedSprite
# Movement variables
var velocity = Vector2()
var speed = 250
var PLAYER_DIR = Direction.LEFT
# Gravity settings
var gravity = 1200  # Pixels per second squared
var jump_force = -120
const JUMP_MOD = 3
var JUMP_BUFF := 3.0
enum Player { 
	IDLE = -1, 
	WALKING = -2,
	BUFFERING = -3,
	FALLING = -4,
	JUMPING = -5,
	BOUNCE = -6
}
enum Direction {
	RIGHT = 100,
	LEFT = 101,
}

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	
func _physics_process(delta):
	#this is gravity
	velocity.y += gravity * delta
	handle_state(handle_io())
	velocity = move_and_slide(velocity, Vector2.UP)
	check_step()
	
func flip():
	player_sprite.flip_h = PLAYER_DIR == Direction.LEFT
	wrench_sprite.flip_v = PLAYER_DIR == Direction.RIGHT
	
func reload():
	get_tree().change_scene(get_tree().current_scene.filename)

func handle_io() -> Array:
	if Input.is_action_pressed("ui_accept"):
		reload()
		pass
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
	if Input.is_action_just_pressed("ui_up"):
		io.append(Player.JUMPING)
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
			velocity.y = jump_force * JUMP_BUFF
		[true, _, Player.BOUNCE]:
			velocity.y = jump_force * (JUMP_BUFF * 2)
		_:
			$AnimatedSprite.play("idle")			
			velocity.x = 0  # default fallback

func check_step():
	for i in range(get_slide_count()):
		var coll = get_slide_collision(i)
		if coll.normal != Vector2.UP:
			continue
		var colli = coll.collider
		if colli is StaticBody2D:
			if colli.has_method("on_player_stepped"):
				handle_state(colli.on_player_stepped())
