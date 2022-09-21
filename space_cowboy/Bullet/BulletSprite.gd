extends Sprite

var rotation_speed = 20

func _physics_process(delta):
	rotation += rotation_speed*delta
