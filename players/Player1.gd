extends KinematicBody2D

const SPEED = 80
var movedir = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move():
	movedir = Vector2()
	if Input.is_action_pressed("player1left"):
		movedir.x -= 1
	if Input.is_action_pressed("player1right"):
		movedir.x += 1
	if Input.is_action_pressed("player1down"):
		movedir.y += 1
	if Input.is_action_pressed("player1up"):
		movedir.y -= 1
	move_and_slide(movedir.normalized()*SPEED)
	
func _physics_process(delta):
	move()
	animate_sprite()
	print(movedir)
	
func animate_sprite():
	match movedir:
		Vector2(0, 1):
			$AnimatedSprite.animation = 'down'
		Vector2(0, -1):
			$AnimatedSprite.animation = 'up'
		Vector2(1, 0):
			$AnimatedSprite.animation = 'right'
		Vector2(-1, 0):
			$AnimatedSprite.animation = 'left'
