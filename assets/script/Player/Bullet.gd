extends KinematicBody2D

onready var BRICK_INST = preload("res://assets/scene/Brick/Brick.tscn")
onready var texture = $Texture
export var direction := Vector2.ZERO
export var BULLET_TYPE = 0
var velocity = Vector2.ZERO
var gravity = 1000
var speed = 750
var limit = 30
var zero = 0

func _physics_process(delta):
	anim_bullet()
	place_tile()	
	velocity.y += gravity * delta
	position += direction * speed * delta
	rotation = direction.angle()
	velocity = move_and_slide(velocity, Vector2.UP)	
	
func anim_bullet():
	match BULLET_TYPE:
		0:
			texture.play("0")	
		1:
			texture.play("1")
		2:
			texture.play("2")
# need works! still buggy!
func place_tile():
	if BULLET_TYPE == 2:
		zero += 0.5
		if zero >= limit:
			queue_free()
			var brick = BRICK_INST.instance()
			brick.BRICK_TYPE = BULLET_TYPE			
			get_parent().add_child(brick)
			brick.global_position = position
			return
		return
	var count = get_slide_count()
	for i in range(count):
		var collision = get_slide_collision(i)
		var hit_pos = collision.position
		var collider = collision.collider
				
		if collider is TileMap:
			queue_free()			
			var tilemap = collider as TileMap
			var brick = BRICK_INST.instance()
			brick.BRICK_TYPE = BULLET_TYPE			
			get_parent().add_child(brick)
			var adjusted_hit_pos = hit_pos + Vector2(-tilemap.cell_size.x / 2, -tilemap.cell_size.y / 2)			
			brick.global_position = adjusted_hit_pos
