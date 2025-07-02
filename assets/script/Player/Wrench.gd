extends Node2D

#export var float_distance = 2.0  # Distance from player
var BulletScene = preload("res://assets/scene/Player/Bullet.tscn")

export var float_distance := 30.0
export var aim_line_length := 100
export var aim_line_color := Color.red
export var aim_line_width := 2.0

func _ready():
	update()  # Draw immediately

func _process(_delta):
	$AnimatedSprite.play("idle")
	#look_at(get_global_mouse_position())
	var player_global_pos = get_parent().global_position
	var mouse_pos = get_global_mouse_position()
	var to_mouse = mouse_pos - player_global_pos
	var direction = to_mouse.normalized()

	# Point gun toward mouse
	rotation = direction.angle()

	# Float gun at a distance from the player
	global_position = player_global_pos + direction * 5


#func _draw():
#	var direction = (get_global_mouse_position() - global_position).normalized()
#	var start_point = Vector2.ZERO
#	var end_point = direction * aim_line_length

#	draw_line(start_point, end_point, aim_line_color, aim_line_width)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		#print("here!")
		shoot()


func shoot():
	var bullet = BulletScene.instance()
	get_parent().get_parent().add_child(bullet)
	var muzzle = $Position2D
	bullet.global_position = muzzle.global_position
	var dir = (get_global_mouse_position() - muzzle.global_position).normalized()
	bullet.direction = dir 

	
