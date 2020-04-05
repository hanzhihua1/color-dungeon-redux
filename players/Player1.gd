extends "res://enemies/entity.gd"

var spritedir = 'down'
var state = 'default'

# Called when the node enters the scene tree for the first time.
func _ready():
	SPEED = 80
	TYPE = 'PLAYER'
	movedir = Vector2()
	$AnimationPlayer.play("walk_down")
	


func controls_loop():
	movedir = Vector2()
	if Input.is_action_pressed("player1left"):
		movedir.x -= 1
	if Input.is_action_pressed("player1right"):
		movedir.x += 1
	if Input.is_action_pressed("player1down"):
		movedir.y += 1
	if Input.is_action_pressed("player1up"):
		movedir.y -= 1
	if Input.is_action_just_pressed("a"):
		use_item(preload("res://items/Sword.tscn"))
		state = 'swing'
		$AnimationPlayer.play('swing_'+spritedir)
	
func _physics_process(delta):
	match state:
		'default':
			state_default()
		'swing':
			state_swing()


func state_default():
	animate_movement()
	controls_loop()
	movement_loop()
	damage_loop()
	
func animate_movement():
	if is_on_wall():
		if test_move(transform, Vector2(-1, 0)) and movedir == Vector2(-1, 0):
			$AnimationPlayer.play("push_left")
		if test_move(transform, Vector2(1, 0))  and movedir == Vector2(1, 0):
			$AnimationPlayer.play("push_right")
		if test_move(transform, Vector2(0, 1)) and movedir == Vector2(0, 1):
			$AnimationPlayer.play("push_down")
		if test_move(transform, Vector2(0, -1)) and movedir == Vector2(0, -1):
			$AnimationPlayer.play("push_up")
	else:
		match movedir:
			Vector2(0, 1):
				spritedir = 'down'
				anim_switch('walk')
			Vector2(0, -1):
				spritedir = 'up'
				anim_switch('walk')
			Vector2(1, 0):
				spritedir = 'right'
				anim_switch('walk')
			Vector2(-1, 0):
				spritedir = 'left'
				anim_switch('walk')
			Vector2(0, 0):
				anim_switch('idle')
		

func state_swing():
	damage_loop()
	movement_loop()
	movedir = dir.center

func anim_switch(animation):
	var new_anim = str(animation)+'_'+spritedir
	if $AnimationPlayer.current_animation != new_anim:
		$AnimationPlayer.play(new_anim)
