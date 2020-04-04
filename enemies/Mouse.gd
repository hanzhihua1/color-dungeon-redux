extends "res://enemies/entity.gd"

var think_time = 15
var think = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SPEED = 80
	movedir = dir.center
	
func _physics_process(delta):
	if think == 0:
		movedir = dir.rand()
		think = think_time
	else:
		think -= 1
