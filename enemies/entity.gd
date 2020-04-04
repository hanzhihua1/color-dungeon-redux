extends KinematicBody2D

var SPEED = 0
var movedir = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move():
	move_and_slide(movedir.normalized()*SPEED)
	
func _physics_process(delta):
	move()
	animate_sprite()
	
func animate_sprite():
	match movedir:
		Vector2(0, 1):
			$AnimatedSprite.animation = 'down'
			$AnimatedSprite.flip_h = false
		Vector2(0, -1):
			$AnimatedSprite.animation = 'up'
			$AnimatedSprite.flip_h = false
		Vector2(1, 0):
			$AnimatedSprite.animation = 'right'
			$AnimatedSprite.flip_h = false
		Vector2(-1, 0):
			$AnimatedSprite.animation = 'right'
			$AnimatedSprite.flip_h = true
