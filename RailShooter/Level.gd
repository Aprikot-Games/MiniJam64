extends Spatial
export (PackedScene) var TerrainBlock

var last_spawn_point = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var camera_pos = $Ship/Ship.transform.origin
	camera_pos.z -= 10
	camera_pos.y += 2
	$Camera.transform.origin.z = camera_pos.z
	var int_cam = int(camera_pos.z)
	if int(camera_pos.z) % 10 == 0 and int_cam != last_spawn_point:
		print("Spawn new square")
		last_spawn_point = int_cam
		var new_terrain_chunk = TerrainBlock.instance()
		var x = Vector3(5, 0, 0)
		var y = Vector3(0, 0.2, 0)
		var z = Vector3(0, 0, 5)
		new_terrain_chunk.transform.basis.x = x
		new_terrain_chunk.transform.basis.y = y
		new_terrain_chunk.transform.basis.z = z
		add_child(new_terrain_chunk)
		new_terrain_chunk.transform.origin.z = int_cam + 50
	var cam_diff_x = camera_pos.x - $Camera.transform.origin.x
	var cam_diff_y = camera_pos.y - $Camera.transform.origin.y
	if cam_diff_x > 0.5 and $Camera.transform.origin.x < 0.5:
		$Camera.transform.origin.x += 0.05
	elif cam_diff_x < -0.5 and $Camera.transform.origin.x > -0.5:
		$Camera.transform.origin.x -= 0.05
	if cam_diff_y > 0.5 and $Camera.transform.origin.y > -0.5:
		$Camera.transform.origin.y += 0.05
	elif cam_diff_y < -0.5 and $Camera.transform.origin.y > -0.5:
		$Camera.transform.origin.y -= 0.05
