extends KinematicBody2D

var TYPE = 'ENEMY'
var SPEED = 0
var DAMAGE = 0
var movedir = Vector2()

var knockdir = Vector2()
var hitstun = 0
var health = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func movement_loop():
	var motion
	if hitstun == 0:
		motion = movedir.normalized()*SPEED
	else:
		motion = knockdir.normalized()*SPEED*1.5
	move_and_slide(motion)


func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	for areas in $Hitbox.get_overlapping_areas():
		var body = areas.get_parent()
		if hitstun == 0 and body.get('DAMAGE') != null and body.get('TYPE') != TYPE:
			health -= body.get('DAMAGE')
			hitstun = 10
			knockdir = transform.origin - body.transform.origin
		
func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(newitem.get_name(), self))
	add_child(newitem)
	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() > newitem.maxamount:
		newitem.queue_free()
