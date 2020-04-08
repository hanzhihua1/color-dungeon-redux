extends "res://enemies/entity.gd"



var think_time = 15
var think = 0
var COLOR = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	COLOR = dir.color(randi()%5 + 1)
	$AnimatedSprite.animation = COLOR+'_down'
	SPEED = 80
	DAMAGE = 1
	health = 2
	movedir = dir.center
	
func controls_loop():
	if think == 0:
		movedir = dir.rand()
		think = think_time
	else:
		think -= 1
	
func _physics_process(delta):
	controls_loop()
	movement_loop()
	animate_sprite(COLOR)
	damage_loop()
	
	if health <= 0:
		queue_free()
	
func animate_sprite(COLOR):
	match movedir:
		Vector2(0, 1):
			$AnimatedSprite.animation = COLOR+'_down'
			$AnimatedSprite.flip_h = false
		Vector2(0, -1):
			$AnimatedSprite.animation = COLOR+'_up'
			$AnimatedSprite.flip_h = false
		Vector2(1, 0):
			$AnimatedSprite.animation = COLOR+'_right'
			$AnimatedSprite.flip_h = false
		Vector2(-1, 0):
			$AnimatedSprite.animation = COLOR+'_right'
			$AnimatedSprite.flip_h = true
