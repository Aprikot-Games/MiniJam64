extends Spatial

var velocity = Vector3(0, 0, 0)
var speed = 15
var rot_x = 0
var rot_y = 0
var total_rot = 0
const AIM_SPEED = PI/96
const RET_AIM_SPEED = AIM_SPEED / 2
const RAIL_X = 6
const RAIL_Y = 10
signal hero_shoot
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.z = speed
	pass # Replace with function body.

func process_y_rot():
	if Input.is_action_pressed("move_right"):
		if rot_y > -PI/6:
			rot_y -= AIM_SPEED
	elif Input.is_action_pressed("move_left"):
		if rot_y < PI/6:
			rot_y += AIM_SPEED
	elif rot_y > -RET_AIM_SPEED and rot_y < RET_AIM_SPEED:
		rot_y = 0
	elif rot_y > 0:
		rot_y -= RET_AIM_SPEED
	elif rot_y < 0:
		rot_y += RET_AIM_SPEED

func process_x_rot():
	if Input.is_action_pressed("move_down"):
		if rot_x > -PI/6:
			rot_x -= AIM_SPEED
	elif Input.is_action_pressed("move_up"):
		if rot_x < PI/6:
			rot_x += AIM_SPEED
	elif rot_x > -RET_AIM_SPEED and rot_x < RET_AIM_SPEED:
		rot_x = 0
	elif rot_x > 0:
		rot_x -= RET_AIM_SPEED
	elif rot_x < 0:
		rot_x += RET_AIM_SPEED

func _physics_process(delta):
	process_x_rot()
	process_y_rot()
	$Ship.transform.basis = Basis()
	$Ship.rotate_object_local(Vector3(0, 1, 0), rot_y)
	$Ship.rotate_object_local(Vector3(1, 0, 0), rot_x)
	velocity.z = speed * cos(rot_x) * cos(rot_y)
	velocity.x = speed * sin(rot_y)
	velocity.y = -speed * sin(rot_x)
	if $Ship.transform.origin.x < -RAIL_X and velocity.x < 0:
		velocity.x = 0
	elif $Ship.transform.origin.x > RAIL_X and velocity.x > 0:
		velocity.x = 0
	if $Ship.transform.origin.y < 0 and velocity.y < 0:
		velocity.y = 0
	elif $Ship.transform.origin.y > RAIL_Y and velocity.y > 0:
		velocity.y = 0
	#print($Ship.transform.origin)
	#velocity.y = -speed * sin(rot_x)
	$Ship.move_and_slide(velocity)
	if Input.is_action_just_pressed("shoot"):
		emit_signal("hero_shoot")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
