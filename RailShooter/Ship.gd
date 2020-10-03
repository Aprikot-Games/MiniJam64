extends KinematicBody

var velocity = Vector3()
var speed = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.z = speed + 10
	pass

func _physics_process(delta):
	move_and_slide(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
