extends KinematicBody

var velocity = Vector3()
var speed = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.z = speed + 10
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("move_right") and self.velocity.x > -10:
		print(velocity)
		# Move as long as the key/button is pressed.
		self.velocity.x -= speed
		#$Camera.position.x -= (speed * 0.2) * delta
	elif Input.is_action_pressed("move_left") and self.velocity.x < 10:
		self.velocity.x += speed
	elif self.velocity.x > 0:
		self.velocity.x -= 0.5
	elif self.velocity.x < 0:
		self.velocity.x += 0.5
	if Input.is_action_pressed("move_up") and self.velocity.y < 10:
		#print(velocity)
		# Move as long as the key/button is pressed.
		self.velocity.y += speed
		#$Camera.position.x -= (speed * 0.2) * delta
	elif Input.is_action_pressed("move_down") and self.velocity.y > -10:
		self.velocity.y -= speed
	elif self.velocity.y > 0:
		self.velocity.y -= 0.5
	elif self.velocity.y < 0:
		self.velocity.y += 0.5
	move_and_slide(velocity)
		#$Camera.position.x += (speed * 0.2) * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
