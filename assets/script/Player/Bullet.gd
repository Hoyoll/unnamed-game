extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#export var speed := 600
export var direction := Vector2.ZERO

var speed = 750

func _physics_process(delta):
	$Texture.play("idle")
	position += direction * speed * delta
	if not get_viewport_rect().has_point(global_position):
	   queue_free()
#func _physics_process(delta):
	#$AnimatedSprite.play("fly")
	#if direction == Vector2.ZERO:
		#queue_free()
		#return

	#var velocity = direction * speed
	#var collision = move_and_collide(velocity * delta)

	#if collision:
		# Example: print collided object
	#	print("Hit: ", collision.collider.name)
		# Optional: handle damage, effects, etc.
	#queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
