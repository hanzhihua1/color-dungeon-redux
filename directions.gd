extends Node

const center = Vector2(0, 0)
const left = Vector2(-1, 0)
const right = Vector2(1, 0)
const up = Vector2(0, -1)
const down = Vector2(0, 1)

func rand():
	var d = randi()%4
	match d:
		0: 
			return left
		1: 
			return right
		2:
			return up
		3: 
			return down
			
func orientation(d):
	match d:
		'left':
			return Vector2(-1, 0)
		'right':
			return Vector2(1, 0)
		'up':
			return Vector2(0, -1)
		'down':
			return Vector2(0, 1)
	
func color(c):
	match c:
		0:
			return 'gray'
		1:
			return 'red'
		2:
			return 'blue'
		3: 
			return 'green'
		4: 
			return 'yellow' 
		5:
			return 'purple'
