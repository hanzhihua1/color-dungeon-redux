extends Node2D

var map_seed = 0

func _ready():
	randomize()
	map_seed = randi()
