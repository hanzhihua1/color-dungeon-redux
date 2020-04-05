extends KinematicBody2D

var TYPE = 'PLAYER'
var DAMAGE = 2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var DISTANCE = 3
var state = 'ground'
var picked_player
var initial_position = Vector2()
var final_position = Vector2()
var movedir = Vector2()
var t = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	match state:
		'picked':
			self.position = picked_player.global_position + Vector2(0, -12)
		'thrown':
			if t < 1:
				t += 4*delta
				if not test_move(transform, movedir):
					self.position = initial_position.linear_interpolate(final_position, t)
				elif movedir == Vector2(1, 0) or movedir == Vector2(-1, 0):
					var pos = initial_position.linear_interpolate(final_position, t)
					self.position.y = pos.y
			else:
				state = 'ground'
				set_collision_layer_bit(1, true)
				set_collision_mask_bit(3, true)
				
				

func _input(event):
	if Input.is_action_just_released('b'):
		set_collision_layer_bit(1, false)
		set_collision_mask_bit(3, false)
		match state:
			'ground':
				var bodies = $Area2D.get_overlapping_bodies()
				for b in bodies:
					if b.name == 'Player' and state == 'ground':
						picked_player = get_tree().get_root().find_node('Player', true, false)
						picked_player.state = 'carrying'
						state = 'picked'
			'picked':
				movedir = dir.orientation(picked_player.spritedir)
				state = 'thrown'
				picked_player.state = 'default'
				initial_position = self.position
				final_position = picked_player.global_position + DISTANCE*16*movedir
				t = 0
