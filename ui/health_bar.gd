extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var health = get_parent().health
var heart_containers = 5

var heart_full = preload("res://art/health_bar/health_full.png")
var heart_half = preload("res://art/health_bar/health_half.png")
var heart_empty = preload("res://art/health_bar/health_empty.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(heart_containers):
		var heart = TextureRect.new()
		heart.name = str(i + 1)
		heart.texture = heart_full
		add_child(heart)
	update_partial(health)

func _process(delta):
	if get_parent().health != null:
		health = get_parent().health
		update_partial(health)

func update_partial(value):
	for i in get_child_count():
		if value > i * 2 + 1:
			get_child(i).texture = heart_full
		elif value > i * 2:
			get_child(i).texture = heart_half
		else:
			get_child(i).texture = heart_empty
