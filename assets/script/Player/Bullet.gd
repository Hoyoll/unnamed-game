extends KinematicBody2D

onready var BRICK_INST = preload("res://assets/scene/Brick/Brick.tscn")

export var direction := Vector2.ZERO
export var BULLET_TYPE = 0
var velocity = Vector2.ZERO
var gravity = 1000
var speed = 750

func _physics_process(delta):
	$Texture.play("idle")
	velocity.y += gravity * delta
	position += direction * speed * delta
	rotation = direction.angle()
	place_tile()
	velocity = move_and_slide(velocity, Vector2.UP)	
	if not get_viewport_rect().has_point(global_position):
	   queue_free()

# need works! still buggy!
func place_tile():
	var count = get_slide_count()
	for i in range(count):
		var collision = get_slide_collision(i)
		var hit_pos = collision.position
		var collider = collision.collider

		if collider is TileMap:
			var tilemap = collider as TileMap
			var brick = BRICK_INST.instance()
			get_parent().add_child(brick)
			var adjusted_hit_pos = hit_pos + Vector2(-tilemap.cell_size.x / 2, -tilemap.cell_size.y / 2)			
			
			brick.global_position = adjusted_hit_pos
			
			#var cell = tilemap.world_to_map(c)
			#print("Hit TileMap at cell: ", cell, " (world pos: ", hit_pos, ")")
			#tilemap.set_cellv(cell, -1)
			#tilemap.set_cellv(cell, 0)
			queue_free()
#			var offsets = [
#				Vector2(0, 0),   # hit cell
#				Vector2(-1, 0),  # left
#				Vector2(0, -1),  # above				
#				Vector2(1, 0),   # right								
#				#Vector2(0, 1)    # below
#			]
#
#			for offset in offsets:
#				var check_cell = cell + offset
#				if tilemap.get_cellv(check_cell) != -1:
#					continue
#				else:
#					tilemap.set_cellv(check_cell, 0)
#					print("Placed tile at:", check_cell)

