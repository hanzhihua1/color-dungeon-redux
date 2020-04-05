extends "res://enemies/entity.gd"

var think_time = 15
var think = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SPEED = 80
	TYPE = 'ENEMY'
	DAMAGE = 1
	movedir = dir.center
	
func controls_loop():
	if think == 0:
		movedir = dir.rand()
		think = think_time
	else:
		think -= 1
	
func _physics_process(delta):
	#controls_loop()
	movement_loop()
	animate_sprite()
	damage_loop()
	
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
