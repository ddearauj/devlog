extends KinematicBody2D

var bullet = preload("res://Bullet/Bullet.tscn")

export var ACCELERATION = 200
export var MAX_SPEED = 50

export var FRICTION = 10000

var velocity = Vector2.ZERO
var animationPlayer = null
var looking_rotation = 1
var x_increment = 15
var y_increment = 0

func _ready():
	animationPlayer = $AnimationPlayer

func _physics_process(delta):
	move_state(delta)
	shoot(delta)

func move_state(delta):
	var input_vector = get_input_vector()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0 and input_vector.y == 0:
#			print("MOVING RIGHT")
			animationPlayer.play("WalkRight")
			looking_rotation = 0
			x_increment = 15
			y_increment = 0
			
		elif input_vector.x < 0 and input_vector.y == 0:
			animationPlayer.play("WalkLeft")
			looking_rotation = 2
			x_increment = -15
			y_increment = 0

		elif input_vector.y > 0 and input_vector.x == 0:
			animationPlayer.play("WalkDown")
			looking_rotation = 1
			y_increment = 15
			x_increment = 0
			
		elif input_vector.y < 0 and input_vector.x == 0:
			animationPlayer.play("WalkUp")
			looking_rotation = 3
			y_increment = -15
			x_increment = 0
			
		velocity = move(delta, input_vector)
	else:

		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	

func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	return input_vector
	

func move(delta, input_vector):
	velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	var collision = move_and_collide(velocity * delta)
	if collision:
#		emit_signal("door_colission")
		pass
	else:
		velocity = move_and_slide(velocity)
	
	return velocity

func shoot(delta):
	if Input.is_action_just_pressed("shoot"):
		var b = bullet.instance()
		owner.add_child(b)
		b.position = position
		b.position.x += x_increment
		b.position.y += y_increment
		b.rotation = deg2rad(90*looking_rotation)
