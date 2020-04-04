extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const WINDOW_WIDTH = 512
const WINDOW_HEIGHT = 288

var rooms = 16
var spawn_room = Vector2(0, 0)
var current_room = spawn_room
var array = [spawn_room] #Array of Vector2(), containing the room coordinates.
var RoomScene = preload("res://dungeon/rooms/Room.tscn")
var RoomScene2 = preload("res://dungeon/rooms/Room2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	seed(settings.map_seed)
	while len(array) < rooms:
		propose_room()
		
	#build_rooms() #dont forget to change spawn room
	minimap()
		
func propose_room():
	var vector = dir.rand()
	var proposed_room = current_room + vector
	if not array.has(proposed_room):
		array.append(proposed_room)
		current_room += vector
	else: 
		current_room = array[randi()%len(array)]
		
func build_rooms():
	for i in array:
		var rand = randi()%2
		if rand == 0: 
			var room = RoomScene.instance()
			add_room(room, i)
		if rand == 1:
			var room = RoomScene2.instance()
			add_room(room, i)
			

func add_room(room, i):
	room.position = Vector2(WINDOW_WIDTH*i.x, WINDOW_HEIGHT*i.y) - Vector2(WINDOW_WIDTH, WINDOW_HEIGHT)/2
	add_child(room)

func minimap():
	for i in array:
		set_cell(i.x, i.y, 0)
	set_cell(spawn_room.x, spawn_room.y, 1)
	
	var end_room = spawn_room
	for i in array:
		if (i - spawn_room).length() >= (end_room - spawn_room).length():
			end_room = i
	print(end_room, spawn_room)
	set_cell(end_room.x, end_room.y, 2)
