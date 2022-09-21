extends KinematicBody2D


var speed = 50

var path: Array = []
var levelNav: Navigation2D = null
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)


func move(delta):
	var velocity = Vector2(0, speed)
	var collision = move_and_collide(velocity * delta)
	if collision:
#		emit_signal("door_colission")
		pass
	else:
		velocity = move_and_slide(velocity)
	
	return velocity
