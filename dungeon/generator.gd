extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const WINDOW_WIDTH = 512
const WINDOW_HEIGHT = 288

var rooms = 20
var array = [Vector2(0, 0)] #Array of Vector2(), containing the room coordinates.
var current_room = Vector2(0, 0)
var RoomScene = preload("res://dungeon/rooms/Room.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	while len(array) < rooms:
		propose_room()
	print('rooms', array)
	build_rooms()
		
		
func propose_room():
	var vector = random_vector()
	var proposed_room = current_room + vector
	if not array.has(proposed_room):
		array.append(proposed_room)
		current_room += vector

		
func random_vector():
	var rand = randi()%4
	if rand == 0:
		return Vector2(1, 0)
	if rand == 1:
		return Vector2(-1, 0)
	if rand == 2:
		return Vector2(0, 1)
	if rand == 3:
		return Vector2(0, -1)

func build_rooms():
	for i in array:
		var room = RoomScene.instance()
		room.position = Vector2(WINDOW_WIDTH*i.x, WINDOW_HEIGHT*i.y)
		add_child(room)
		print(i)
