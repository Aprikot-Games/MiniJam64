extends Spatial

var velocity = Vector3(0, 0, 0)
var speed = 15
var rot_y = 0
var total_rot = 0
const AIM_SPEED = PI/160
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.z = speed
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		if rot_y < PI/6:
			rot_y += AIM_SPEED
	elif rot_y > 0:
		rot_y -= AIM_SPEED
	$Ship.transform.basis = Basis()
	print(rot_y)
	$Ship.rotate_object_local(Vector3(0, 1, 0), rot_y)
	total_rot += rot_y
	$Ship.move_and_slide(velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
