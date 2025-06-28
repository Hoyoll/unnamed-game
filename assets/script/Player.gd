extends KinematicBody2D

# Movement variables
var velocity = Vector2()
var speed = 200

# Gravity settings
var gravity = 800  # Pixels per second squared
var jump_force = -400

# Ground detection
var is_on_floor = false

func _physics_process(delta):
	# Apply gravity
	velocity.y += gravity * delta

	# Horizontal movement (left/right)
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed

	# Jump
	if is_on_floor and Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_force
	if Input.is_action_just_pressed("ui_accept"):
		var tilemap = get_parent().get_node("TileMap")
		var cell = tilemap.world_to_map(global_position)
		tilemap.set_cellv(cell, 0)  # Place tile with ID 0# 0 = tile ID from your TileSet
	# Move and check if on floor
	velocity = move_and_slide(velocity, Vector2.UP)
	is_on_floor = is_on_floor()
