extends KinematicBody2D

var speed = 50
var velocity = Vector2.ZERO
var path: Array = []
var levelNav: Navigation2D = null
var player = null

onready var line2d = $Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNav = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("SpaceCowboy"):
		player = tree.get_nodes_in_group("SpaceCowboy")[0]
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	line2d.global_position = Vector2.ZERO
	if player and levelNav:
		generate_path()
		navigate()
	move(delta)


func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * speed
		
	if global_position == path[0]:
		path.pop_front()
	
func generate_path():
	if player != null and levelNav != null:
		path = levelNav.get_simple_path(global_position, player.global_position, false)
		line2d.points = path

func move(delta):
	velocity = move_and_slide(velocity)
