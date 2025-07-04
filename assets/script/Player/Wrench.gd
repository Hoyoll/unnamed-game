extends Node2D

#export var float_distance = 2.0  # Distance from player
var BulletScene = preload("res://assets/scene/Player/Bullet.tscn")

export var float_distance := 30.0
export var aim_line_length := 100
export var aim_line_color := Color.red
export var aim_line_width := 2.0
var ammo = [0, 1, 2];
var current_bull = 0

func _ready():
	ammo.shuffle()
#	ammo.append_array([0,1,2])
	update()  # Draw immediately

func _process(_delta):
	$AnimatedSprite.play("idle")
	anim_bull()
	#look_at(get_global_mouse_position())
	var player_global_pos = get_parent().global_position
	var mouse_pos = get_global_mouse_position()
	var to_mouse = mouse_pos - player_global_pos
	var direction = to_mouse.normalized()

	# Point gun toward mouse
	rotation = direction.angle()

	# Float gun at a distance from the player
	global_position = player_global_pos + direction * 5


func anim_bull():
	var count = ammo.size()
	if count == 0:
		$BulletBall.play("empty")
		return
	match ammo[current_bull]:
		0:
			$BulletBall.play("0")
		1: 
			$BulletBall.play("1")
		2: 
			$BulletBall.play("2")
		

func cycle_item_bar(i: int):
	var length = ammo.size()
	print(length)
	if current_bull + i < 0:
		current_bull = length - 1
	elif current_bull + i >= length:
		current_bull = 0
		

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		#print("here!")
		shoot()

	

func shoot():
	if ammo.size() == 0:
		return
	var bullet = BulletScene.instance()
	get_parent().get_parent().add_child(bullet)
	var muzzle = $Position2D
	bullet.BULLET_TYPE = ammo[current_bull]
	ammo.remove(current_bull)
	bullet.global_position = muzzle.global_position
	var dir = (get_global_mouse_position() - muzzle.global_position).normalized()
	bullet.direction = dir 

	
