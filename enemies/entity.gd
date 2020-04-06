extends KinematicBody2D

var SPEED = 0
var DAMAGE = 0
var movedir = Vector2()

var knockdir = Vector2()
var hitstun = 0
var health = 1 

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hurtbox.connect('area_entered', self, '_on_Hurtbox_area_entered')

func movement_loop():
	var motion
	if hitstun == 0:
		motion = movedir.normalized()*SPEED
	else:
		motion = knockdir.normalized()*125
	move_and_slide(motion)


func damage_loop():
	if hitstun > 0:
		hitstun -= 1
		
func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(newitem.get_name(), self))
	add_child(newitem)
	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() > newitem.maxamount:
		newitem.queue_free()
		
func knockback(body):
	health -= body.get('DAMAGE')
	hitstun = 10
	knockdir = global_transform.origin - body.global_transform.origin

func _on_Hurtbox_area_entered(area):
	var body = area.get_parent()
	if (hitstun == 0 and body.get('DAMAGE') != null):
		knockback(body)
